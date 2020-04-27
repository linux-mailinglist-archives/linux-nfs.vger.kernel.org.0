Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409911BACED
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2020 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgD0Sip (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Apr 2020 14:38:45 -0400
Received: from fieldses.org ([173.255.197.46]:36460 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgD0Sip (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Apr 2020 14:38:45 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id DFE153AF; Mon, 27 Apr 2020 14:38:44 -0400 (EDT)
Date:   Mon, 27 Apr 2020 14:38:44 -0400
To:     trondmy@kernel.org
Cc:     Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/7] mountd: Ignore transient and non-fatal filesystem
 errors in nfsd_fh()
Message-ID: <20200427183844.GE31277@fieldses.org>
References: <20200416221252.82102-1-trondmy@kernel.org>
 <20200416221252.82102-2-trondmy@kernel.org>
 <20200416221252.82102-3-trondmy@kernel.org>
 <20200416221252.82102-4-trondmy@kernel.org>
 <20200416221252.82102-5-trondmy@kernel.org>
 <20200416221252.82102-6-trondmy@kernel.org>
 <20200416221252.82102-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416221252.82102-7-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 16, 2020 at 06:12:51PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> In nfsd_fh(), if the error returned by the downcall is transient,
> then we should ignore it. Only reject the export if the filesystem
> path is truly not exportable.
> This fixes a case where we can see spurious NFSERR_STALE errors
> being returned by knfsd.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  utils/mountd/cache.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
> index 0f323226b12a..79d3ee085a90 100644
> --- a/utils/mountd/cache.c
> +++ b/utils/mountd/cache.c
> @@ -843,8 +843,14 @@ static void nfsd_fh(int f)
>  			}
>  		}
>  	}
> -	if (found && 
> -	    found->e_mountpoint &&
> +
> +	if (!found) {
> +		/* The missing dev could be what we want, so just be
> +		 * quiet rather than returning stale yet
> +		 */
> +		if (dev_missing)
> +			goto out;
> +	} else if (found->e_mountpoint &&
>  	    !is_mountpoint(found->e_mountpoint[0]?
>  			   found->e_mountpoint:
>  			   found->e_path)) {
> @@ -855,17 +861,12 @@ static void nfsd_fh(int f)
>  		 */
>  		/* FIXME we need to make sure we re-visit this later */
>  		goto out;
> +	} else if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0) {
> +		if (!path_lookup_error(errno))
> +			goto out;
> +		/* The kernel is saying the path is unexportable */
> +		found = NULL;
>  	}
> -	if (!found && dev_missing) {
> -		/* The missing dev could be what we want, so just be
> -		 * quite rather than returning stale yet
> -		 */
> -		goto out;
> -	}
> -
> -	if (found)
> -		if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
> -			found = 0;
>  
>  	bp = buf; blen = sizeof(buf);
>  	qword_add(&bp, &blen, dom);

Is everybody else better at reading this kind of patch?  Between the
code reshuffling and the conditionals, it's almost totally opaque to me.
I'd have split it up something like the below.--b.

commit b0b623281017
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Thu Apr 16 18:12:51 2020 -0400

    mountd: Ignore transient and non-fatal filesystem errors in nfsd_fh()
    
    In nfsd_fh(), if the error returned by the downcall is transient,
    then we should ignore it. Only reject the export if the filesystem
    path is truly not exportable.
    This fixes a case where we can see spurious NFSERR_STALE errors
    being returned by knfsd.
    
    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index bcd4b3ce5bb2..0426b171f040 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -826,8 +826,12 @@ static void nfsd_fh(int f)
 		 */
 		/* FIXME we need to make sure we re-visit this later */
 		goto out;
-	} else if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
-			found = 0;
+	} else if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0) {
+		if (!path_lookup_error(errno))
+			goto out;
+		/* The kernel is saying the path is unexportable */
+		found = NULL;
+	}
 
 	bp = buf; blen = sizeof(buf);
 	qword_add(&bp, &blen, dom);

commit 931a2e77f954
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Mon Apr 27 13:22:30 2020 -0400

    rearrange logic; no change in behavior

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 8f54e37b7936..bcd4b3ce5bb2 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -808,8 +808,14 @@ static void nfsd_fh(int f)
 			}
 		}
 	}
-	if (found && 
-	    found->e_mountpoint &&
+
+	if (!found) {
+		/* The missing dev could be what we want, so just be
+		 * quiet rather than returning stale yet
+		 */
+		if (dev_missing)
+			goto out;
+	} else if (found->e_mountpoint &&
 	    !is_mountpoint(found->e_mountpoint[0]?
 			   found->e_mountpoint:
 			   found->e_path)) {
@@ -820,16 +826,7 @@ static void nfsd_fh(int f)
 		 */
 		/* FIXME we need to make sure we re-visit this later */
 		goto out;
-	}
-	if (!found && dev_missing) {
-		/* The missing dev could be what we want, so just be
-		 * quite rather than returning stale yet
-		 */
-		goto out;
-	}
-
-	if (found)
-		if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
+	} else if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
 			found = 0;
 
 	bp = buf; blen = sizeof(buf);
