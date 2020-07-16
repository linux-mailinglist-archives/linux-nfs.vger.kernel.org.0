Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4782B22295F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgGPRUI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgGPRUB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 13:20:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA580C061755
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jul 2020 10:20:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E8A8FC51; Thu, 16 Jul 2020 13:19:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E8A8FC51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594919998;
        bh=1MXe+/E/d1cBP6zTONPNgw/1pHjtKy27itFoO7RmkR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=znkiV6L5n6FLskygl3VDQH6CqfH5mET2Y8sHN4EyD/Vc0jcUDPK+SVb075j8cHIDU
         z1vejcaFjo3+ZrnGqMJGe1fpqVpKMO2j+mZF/EIAzigOZcU9ujVQfzaG2GMsF2+Gl3
         dWCQmwQt/p/ixTpjKf+Vx+OKkn634QRyR9yhOncM=
Date:   Thu, 16 Jul 2020 13:19:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfs4_show_superblock considered harmful :-)
Message-ID: <20200716171958.GB18568@fieldses.org>
References: <871rn38suc.fsf@notabene.neil.brown.name>
 <20200529220608.GA22758@fieldses.org>
 <87a71n7dek.fsf@notabene.neil.brown.name>
 <20200715185456.GE15543@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715185456.GE15543@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 15, 2020 at 02:54:56PM -0400, J. Bruce Fields wrote:
> commit 4eef57aa4fc0
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Wed Jul 15 13:31:36 2020 -0400
> 
>     nfsd4: fix NULL dereference in nfsd/clients display code
>     
>     Reported-by: NeilBrown <neilb@suse.de>
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ab5c8857ae5a..08b8376c74d7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -507,6 +507,16 @@ find_any_file(struct nfs4_file *f)
>  	return ret;
>  }
>  
> +static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
> +{
> +	struct nfsd_file *ret;
> +
> +	spin_lock(&f->fi_lock);
> +	ret = nfsd_file_get(f->fi_deleg_file);
> +	spin_unlock(&f->fi_lock);
> +	return ret;
> +}
> +
...
> @@ -2513,7 +2527,9 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
>  
>  	ds = delegstateid(st);
>  	nf = st->sc_file;
> -	file = nf->fi_deleg_file;
> +	file = find_deleg_file(nf);
> +	if (!file)
> +		return 0;
>  
>  	seq_printf(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);

Oops, I added a "get" without a corresponding "put".

--b.

commit 8d2edfe45286
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Wed Jul 15 13:31:36 2020 -0400

    nfsd4: fix NULL dereference in nfsd/clients display code
    
    We hold the cl_lock here, and that's enough to keep stateid's from going
    away, but it's not enough to prevent the files they point to from going
    away.  Take fi_lock and a reference and check for NULL, as we do in
    other code.
    
    Reported-by: NeilBrown <neilb@suse.de>
    Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ab5c8857ae5a..9d45117c8c18 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -507,6 +507,16 @@ find_any_file(struct nfs4_file *f)
 	return ret;
 }
 
+static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
+{
+	struct nfsd_file *ret;
+
+	spin_lock(&f->fi_lock);
+	ret = nfsd_file_get(f->fi_deleg_file);
+	spin_unlock(&f->fi_lock);
+	return ret;
+}
+
 static atomic_long_t num_delegations;
 unsigned long max_delegations;
 
@@ -2444,6 +2454,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
 	file = find_any_file(nf);
+	if (!file)
+		return 0;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
@@ -2481,6 +2493,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
 	file = find_any_file(nf);
+	if (!file)
+		return 0;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
@@ -2513,7 +2527,9 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 
 	ds = delegstateid(st);
 	nf = st->sc_file;
-	file = nf->fi_deleg_file;
+	file = find_deleg_file(nf);
+	if (!file)
+		return 0;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
@@ -2529,6 +2545,7 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	seq_printf(s, ", ");
 	nfs4_show_fname(s, file);
 	seq_printf(s, " }\n");
+	nfsd_file_put(file);
 
 	return 0;
 }
