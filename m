Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2AAB6FED8
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2019 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfGVLjX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jul 2019 07:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36343 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfGVLjX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Jul 2019 07:39:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 509E23082E1E
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2019 11:39:22 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-118.rdu2.redhat.com [10.10.121.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 285DC19C77;
        Mon, 22 Jul 2019 11:39:22 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id C39CE20A01; Mon, 22 Jul 2019 07:39:16 -0400 (EDT)
Date:   Mon, 22 Jul 2019 07:39:16 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH 1/2] sqlite.c: restore zero-padding to the
 recovery table names
Message-ID: <20190722113916.GL4131@coeurl.usersys.redhat.com>
References: <20190626190432.16257-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626190432.16257-1-smayhew@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 22 Jul 2019 11:39:22 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ping.

-Scott

On Wed, 26 Jun 2019, Scott Mayhew wrote:

> Commit a8133e1fd1742 removed the zero-padding from the table names and
> broke grace period handling.  Running nfsdcld with verbose logging shows
> messages similar to the following:
> 
> nfsdcld: cld_gracestart: sending client records to the kernel
> nfsdcld: sqlite_iterate_recovery: select statement prepare failed: no such table: rec-1b
> nfsdcld: Doing downcall with status -121
> nfsdcld: cld_inotify_cb: called for EV_READ
> nfsdcld: cld_pipe_open: opening upcall pipe /var/lib/nfs/rpc_pipefs/nfsd/cld
> nfsdcld: cld_gracedone: grace done.
> nfsdcld: Unable to drop table for recovery epoch: no such table: rec-1b
> nfsdcld: Doing downcall with status -121
> 
> Fixes: a8133e1fd1742 ("sqlite.c: Use PRIx64 macro to print 64-bit integers")
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  utils/nfsdcld/sqlite.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
> index cd658ef..5d78d24 100644
> --- a/utils/nfsdcld/sqlite.c
> +++ b/utils/nfsdcld/sqlite.c
> @@ -536,7 +536,7 @@ sqlite_copy_cltrack_records(int *num_rec)
>  		xlog(L_ERROR, "Unable to begin transaction: %s", err);
>  		goto rollback;
>  	}
> -	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%" PRIx64 "\";",
> +	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%016" PRIx64 "\";",
>  			current_epoch);
>  	if (ret < 0) {
>  		xlog(L_ERROR, "sprintf failed!");
> @@ -551,7 +551,7 @@ sqlite_copy_cltrack_records(int *num_rec)
>  		xlog(L_ERROR, "Unable to clear records from current epoch: %s", err);
>  		goto rollback;
>  	}
> -	ret = snprintf(buf, sizeof(buf), "INSERT INTO \"rec-%" PRIx64 "\" "
> +	ret = snprintf(buf, sizeof(buf), "INSERT INTO \"rec-%016" PRIx64 "\" "
>  				"SELECT id FROM attached.clients;",
>  				current_epoch);
>  	if (ret < 0) {
> @@ -704,7 +704,7 @@ sqlite_insert_client(const unsigned char *clname, const size_t namelen)
>  	int ret;
>  	sqlite3_stmt *stmt = NULL;
>  
> -	ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%" PRIx64 "\" "
> +	ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%016" PRIx64 "\" "
>  				"VALUES (?);", current_epoch);
>  	if (ret < 0) {
>  		xlog(L_ERROR, "sprintf failed!");
> @@ -749,7 +749,7 @@ sqlite_remove_client(const unsigned char *clname, const size_t namelen)
>  	int ret;
>  	sqlite3_stmt *stmt = NULL;
>  
> -	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%" PRIx64 "\" "
> +	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%016" PRIx64 "\" "
>  				"WHERE id==?;", current_epoch);
>  	if (ret < 0) {
>  		xlog(L_ERROR, "sprintf failed!");
> @@ -799,7 +799,7 @@ sqlite_check_client(const unsigned char *clname, const size_t namelen)
>  	int ret;
>  	sqlite3_stmt *stmt = NULL;
>  
> -	ret = snprintf(buf, sizeof(buf), "SELECT count(*) FROM  \"rec-%" PRIx64 "\" "
> +	ret = snprintf(buf, sizeof(buf), "SELECT count(*) FROM  \"rec-%016" PRIx64 "\" "
>  				"WHERE id==?;", recovery_epoch);
>  	if (ret < 0) {
>  		xlog(L_ERROR, "sprintf failed!");
> @@ -892,7 +892,7 @@ sqlite_grace_start(void)
>  			goto rollback;
>  		}
>  
> -		ret = snprintf(buf, sizeof(buf), "CREATE TABLE \"rec-%" PRIx64 "\" "
> +		ret = snprintf(buf, sizeof(buf), "CREATE TABLE \"rec-%016" PRIx64 "\" "
>  				"(id BLOB PRIMARY KEY);",
>  				tcur);
>  		if (ret < 0) {
> @@ -916,7 +916,7 @@ sqlite_grace_start(void)
>  		 * values in the grace table, just clear out the records for
>  		 * the current reboot epoch.
>  		 */
> -		ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%" PRIx64 "\";",
> +		ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%016" PRIx64 "\";",
>  				tcur);
>  		if (ret < 0) {
>  			xlog(L_ERROR, "sprintf failed!");
> @@ -977,7 +977,7 @@ sqlite_grace_done(void)
>  		goto rollback;
>  	}
>  
> -	ret = snprintf(buf, sizeof(buf), "DROP TABLE \"rec-%" PRIx64 "\";",
> +	ret = snprintf(buf, sizeof(buf), "DROP TABLE \"rec-%016" PRIx64 "\";",
>  		recovery_epoch);
>  	if (ret < 0) {
>  		xlog(L_ERROR, "sprintf failed!");
> @@ -1028,7 +1028,7 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
>  		return -EINVAL;
>  	}
>  
> -	ret = snprintf(buf, sizeof(buf), "SELECT * FROM \"rec-%" PRIx64 "\";",
> +	ret = snprintf(buf, sizeof(buf), "SELECT * FROM \"rec-%016" PRIx64 "\";",
>  		recovery_epoch);
>  	if (ret < 0) {
>  		xlog(L_ERROR, "sprintf failed!");
> -- 
> 2.17.2
> 
