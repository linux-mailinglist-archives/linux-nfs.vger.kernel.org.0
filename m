Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D92E111E558
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLMOLm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:42 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:34193 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLMOLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmU9R-1hxOHO3fnt-00iVR1; Fri, 13 Dec 2019 15:10:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 03/12] nfsd: handle nfs3 timestamps as unsigned
Date:   Fri, 13 Dec 2019 15:10:37 +0100
Message-Id: <20191213141046.1770441-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RAcT70BOi6dHmwI2QhfGxwpnEjl8Xen3AOmqf/6IFLp0gdD9yWG
 Dbi2Qqva4OJzNwTnQLnAgcWSZU801l9DwallJOmJl3lDQ6NmPxR+lV7AVfgGufQ0qEVmJYU
 jwat9CZOl8PYNTLoJcKZ4H4ycr4wHjknk4DhfVY+Bo3NKExWjUhxgM8r8ID3OgmwyW/U09a
 W1bZYKmA0QU0wXeH5mDVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F9gWEdFUl9Y=:AuUrT6ZxwheXz9gbaX9nA8
 VBcgqdx4pgeuvh4BQK+JdUncPkMUcsR8Zj2wlNwLPAqgeIo/BFVJaIHrej3X6/CahQVYJEbtc
 5ueNY7LVZY2/m5h7FnDwTds4sxJ5iHe6CIq3WOXsHscPZRZdlnjL98GXK32bdiM/4pV4B+1s6
 WaN2XhYi7aTHKeYMXIjOFXjdRSOxAHgHJrjnyJ1Ssp2kX5Hhsy7QaA/Uv2Pu9neunPqVaoluD
 mJwrSoPJfYoIMzZbXCogbym/Qvuz3RS59chkxciH0kYAlrbHaZ1HLtsbJfD428bppcMkI/yL3
 cuy7hX60DPQyGxYGBFHuOOSLJ8TXXvmoTGO+3T+Qku2teQlXKD6vV6ylPdx3FEkXNKB19RYXh
 0bilZ7qRptJk2DG5bEV+QGye+tE0UJuG+37lNCgf5wT126Yh83yKj8V3R5g5ppRgz8f0iQbpb
 D5sIDNRhwr0h+Vh5H5iXVFo5lNU+K0mq40CEDXVV/T0M9hLlb7qUIKTOkkFdkRy2KMZepyrrU
 qVNi6pHe7oVZ3GePPAs8YLWGrDKmzAlMK0MgwQCRU06bvHBP9ukD4oRGDsccxtfqWuggRZJyE
 /Rxu7iEqoIuGFTEp4HwVwIoNOr3S32RXWbMTdfZgwgu6IfZ4yuPSUboNi2QWqlfZWc4Oc55uK
 r6K9TbLIwAORI28te5SuvJNlsT+mBDmGyci3DJVNfNImgKdegYW9/BTQj9Dd/npqKudl8xf8R
 I/v7yXERCFOg6ZOrjUoZjY9m531Il+o6AgLlNDqPWY6KFH11tSH9m+Rr79+UB6gFDn5JdkotO
 DfWtpEstSEUJ/4odyAAgbNlNPhpAfczvJjyaRKrG/Mw7qKr3g9k1i9XtVfykbiIzVU765X3ii
 VWIlLF7vHM26p4ZOWooA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The decode_time3 function behaves differently on 32-bit
and 64-bit architectures: on the former, a 32-bit timestamp
gets converted into an signed number and then into a timestamp
between 1902 and 2038, while on the latter it is interpreted
as unsigned in the range 1970-2106.

Change all the remaining 'timespec' in nfsd to 'timespec64'
to make the behavior the same, and use the current interpretation
of the dominant 64-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs3xdr.c | 20 ++++++++------------
 fs/nfsd/nfsfh.h   |  4 ++--
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 195ab7a0fc89..c997b710af27 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -32,14 +32,14 @@ static u32	nfs3_ftypes[] = {
  * XDR functions for basic NFS types
  */
 static __be32 *
-encode_time3(__be32 *p, struct timespec *time)
+encode_time3(__be32 *p, struct timespec64 *time)
 {
 	*p++ = htonl((u32) time->tv_sec); *p++ = htonl(time->tv_nsec);
 	return p;
 }
 
 static __be32 *
-decode_time3(__be32 *p, struct timespec *time)
+decode_time3(__be32 *p, struct timespec64 *time)
 {
 	time->tv_sec = ntohl(*p++);
 	time->tv_nsec = ntohl(*p++);
@@ -167,7 +167,6 @@ encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	      struct kstat *stat)
 {
 	struct user_namespace *userns = nfsd_user_namespace(rqstp);
-	struct timespec ts;
 	*p++ = htonl(nfs3_ftypes[(stat->mode & S_IFMT) >> 12]);
 	*p++ = htonl((u32) (stat->mode & S_IALLUGO));
 	*p++ = htonl((u32) stat->nlink);
@@ -183,12 +182,9 @@ encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	*p++ = htonl((u32) MINOR(stat->rdev));
 	p = encode_fsid(p, fhp);
 	p = xdr_encode_hyper(p, stat->ino);
-	ts = timespec64_to_timespec(stat->atime);
-	p = encode_time3(p, &ts);
-	ts = timespec64_to_timespec(stat->mtime);
-	p = encode_time3(p, &ts);
-	ts = timespec64_to_timespec(stat->ctime);
-	p = encode_time3(p, &ts);
+	p = encode_time3(p, &stat->atime);
+	p = encode_time3(p, &stat->mtime);
+	p = encode_time3(p, &stat->ctime);
 
 	return p;
 }
@@ -277,8 +273,8 @@ void fill_pre_wcc(struct svc_fh *fhp)
 		stat.size  = inode->i_size;
 	}
 
-	fhp->fh_pre_mtime = timespec64_to_timespec(stat.mtime);
-	fhp->fh_pre_ctime = timespec64_to_timespec(stat.ctime);
+	fhp->fh_pre_mtime = stat.mtime;
+	fhp->fh_pre_ctime = stat.ctime;
 	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 	fhp->fh_pre_saved = true;
@@ -330,7 +326,7 @@ nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
 
 	if ((args->check_guard = ntohl(*p++)) != 0) { 
-		struct timespec time; 
+		struct timespec64 time;
 		p = decode_time3(p, &time);
 		args->guardtime = time.tv_sec;
 	}
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 755e256a9103..495540a248a1 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -42,8 +42,8 @@ typedef struct svc_fh {
 
 	/* Pre-op attributes saved during fh_lock */
 	__u64			fh_pre_size;	/* size before operation */
-	struct timespec		fh_pre_mtime;	/* mtime before oper */
-	struct timespec		fh_pre_ctime;	/* ctime before oper */
+	struct timespec64	fh_pre_mtime;	/* mtime before oper */
+	struct timespec64	fh_pre_ctime;	/* ctime before oper */
 	/*
 	 * pre-op nfsv4 change attr: note must check IS_I_VERSION(inode)
 	 *  to find out if it is valid.
-- 
2.20.0

