Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BBF11E55A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLMOLr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:47 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:53621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfLMOLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MDyoW-1iY6g00PeG-00A05y; Fri, 13 Dec 2019 15:10:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 04/12] nfsd: use timespec64 in encode_time_delta
Date:   Fri, 13 Dec 2019 15:10:38 +0100
Message-Id: <20191213141046.1770441-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tZvyC8/MQsSdMybbn7ZBclcwu9BJ9OSnv+w2Y49XsSD5Al3PHeV
 1BpQWJ8CTGqYOrtPofdSkjDSiAe1FTqlMslMMcslfrQVwZo0TJcZsjeoV0vOa4OfOMwU94z
 cpb4m99r8/SDq4g1TmCXRfhgN390wAf1G4f9P8sD559qT2taHWbpzKYkBd/SYTQnMD1KmaK
 OUpuH4MSQDemrLltAdLrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AdmRwze8Z4E=:xF4d1Q1zbssKpYCKrZAehX
 iOa2n27bjHhFhK+1X3q2tJsP23OQKx+mtiNF0JzO63D5wzhzioYCobJkMXY75MXI1p4YpauX/
 91nixKEqpV3FK7U9yX9/Ve4UVdTp/3UKEyVb0J1l4ctNmsQ+MtIlS8p0WCGPxfkcQKdATaqqQ
 b5rzmP2ZuOozb52J2ySXyLl9GjHDAUWiTUwvJOqkK8eSMZXnNJ/seuwJXVMejhHasDdSiIUse
 wWkn9pIyAUQsOE5WxOE8SU5Q3SA5XCM2O+7hWIJUHWvsCvylPAZCNeFpq1IsENaXZB4kjx5su
 NuKATCHd4a9EtwWD74lkt4PPPsUgfI1tOaT8N7dwQH6Qo2IPi63dJQHQLmT5luY4En7SmwP41
 W/vuVXK7zg3VWzGXk5e3OPpw1W0A1+bhygoX6f2+OgUMcd9L6qILvXmYsxjyO2aOC6Txg1J0r
 KmEz2asupLeds71AnKt0VuxFlj4JEN7EtFwdPj8qzD+NOEzWb2V0NijcKf0TJk3dELj3HgGtF
 nqefQE1umqOWr9WyPFNtgaugDhj4Xe0TYvrMb4CejcV86cXc6B9I5dDNJQVb4wIIcYmBRBNJD
 z6M88crsThjQ/VzH5avisyxpG+HzRYYDIe3sb9YMIX0/dxGnB70sDA9FBlMeNtZ/VCd3sNJJh
 aKHIT4xmXNN8idc4pUoUrYk3PWcVByde3cR0i6K5lRpZzlFAA7V0RnSS/3PNRS/+oGiPMG1w1
 A3L2HPVvXNwsUOMUmASY9x8O+O03OZGvDb3TmVOcjjeIOt7td2Zaolo9hn0PDkEknveBBW9zW
 AmRorA3LJfohba9VLRYd4NtsIFb6+yQecHEynYIXb1jKfa1CRBot2ykyVdzlrGHhjwJPJXeIy
 vH3EdYL4Sl644kr5PE+A==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The values in encode_time_delta are always small and don't
overflow the range of 'struct timespec', so changing it has
no effect.

Change it to timespec64 as a prerequisite for removing the
timespec definition later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d2dc4c0e22e8..d95e9668eeff 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2024,11 +2024,11 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
  */
 static __be32 *encode_time_delta(__be32 *p, struct inode *inode)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	u32 ns;
 
 	ns = max_t(u32, NSEC_PER_SEC/HZ, inode->i_sb->s_time_gran);
-	ts = ns_to_timespec(ns);
+	ts = ns_to_timespec64(ns);
 
 	p = xdr_encode_hyper(p, ts.tv_sec);
 	*p++ = cpu_to_be32(ts.tv_nsec);
-- 
2.20.0

