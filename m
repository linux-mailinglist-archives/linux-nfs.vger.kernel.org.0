Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6519311EC50
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 21:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLMU5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 15:57:20 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:35455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMU5T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 15:57:19 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJVU0-1iQOTT1xgu-00JvWU; Fri, 13 Dec 2019 21:56:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chuck Lever <chuck.lever@oracle.com>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Olga Kornievskaia <kolga@netapp.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 17/24] nfs: fix timstamp debug prints
Date:   Fri, 13 Dec 2019 21:53:45 +0100
Message-Id: <20191213205417.3871055-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BPsskpb/goZHuGLwGJ1x2XQfxqhv8DLj+WuA9nQWoEVfSqSeN/I
 fGS/jLREazuK14w8zqELuRQegSYQUDL6R7qd9r8qD2KYJH0Q89uLdDaZnB9tbLT6UAgENTz
 TWgdOq04Zz9t0gBVAkaD5CKbQ7IbUyd/dHvLHlyi+8l2D+LVQzlW8wqlsVFa7A35ZaxNiSS
 8woZIL/pUXR/kABRL3EKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xADCT6UJRW4=:JIwiGJh/B+y32axL9wUyNJ
 mjMgZReUcesvl3rK9VNPN7H7n0lKP+2Heseh3H+PWkrpcUxSno872ZyWD+HXSbXUsXvDVmWlU
 ig9CBKV6/cf5i9EDx0byURIgX1kKuWCbXhgeDXrmDXiLusJoGlGMA83RsQ3ramscBXiyaEblb
 D3nXD+1TnHlktvnVFSwTCnd4Wio+7K9IIRC/zjvgw6wPpbyygztBemXwrpfvN2/7HKrxWsY8q
 RZRDj7sroLSnxryn6Pi9lA5vbOJ3INa9oeNt0gYnXTdAnsP2aqYP1IoxUVr/W9Mjh0q4kpn1C
 ZqJ2h0JWDqzN6j995ub5QpjfcFaLQBKwfKs6mXhWw9Jx6h5VHYqV4TVAAClpIFRBzSCi2/YeA
 xD6DkKzlnI6G4vt6nLZEinve0xmdmQbyk6Vv4tIxJnSQ6bB17HUAEBI3P/wQqcs9YJKycCDe4
 mf8ZsUH1Bk0c1fAgWjGVYI0drUefdMJgLVwavx4k8LL/vbqDKa9Dsb01RQD71dy57zBMALhhR
 uh0AlgKg6D21L+P6Tv8Df0sA890mAZu3u4Vmz9/2qGiiDp/Iars3qMCEypnKNDi3D25pbH/JZ
 0DYshkArsJ+EWwVPv2QONE9m6ZfKnvmJZZmebQIuK/Te/qD0Kt8FosRTTaW1Bq0eybyokrfwa
 1ac9L//a2fafyHGLcYqWhOEf8jVUtbQtWeuGrqryQKpGrP3POskes4D7vZ3giT4bxZALcIerX
 bWMKud/4acgIrU2prf9iC6PWhnUa5iTWPuVwjbufxNtKyVAXSD/W1buvBQMhx1wec4Us5Fy0P
 B6/vivSsZHDVXYMGDs+pJ+26UNZ1yYdF3QRjIDeCiZIKjjcwloFKxJt4izKJQWp+i41bdrjS+
 XPh+ftuT+CCVyLu+OMZw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Starting in v5.5, the timestamps are correctly passed down as
64-bit seconds with NFSv4 on 32-bit machines, but some debug
statements still truncate them to 'long'.

Fixes: e86d5a02874c ("NFS: Convert struct nfs_fattr to use struct timespec64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfs/nfs4xdr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 936c57779ff4..728d88b6a698 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4097,7 +4097,7 @@ static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, str
 			status = NFS_ATTR_FATTR_ATIME;
 		bitmap[1] &= ~FATTR4_WORD1_TIME_ACCESS;
 	}
-	dprintk("%s: atime=%ld\n", __func__, (long)time->tv_sec);
+	dprintk("%s: atime=%lld\n", __func__, time->tv_sec);
 	return status;
 }
 
@@ -4115,7 +4115,7 @@ static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t *bitmap, s
 			status = NFS_ATTR_FATTR_CTIME;
 		bitmap[1] &= ~FATTR4_WORD1_TIME_METADATA;
 	}
-	dprintk("%s: ctime=%ld\n", __func__, (long)time->tv_sec);
+	dprintk("%s: ctime=%lld\n", __func__, time->tv_sec);
 	return status;
 }
 
@@ -4132,8 +4132,8 @@ static int decode_attr_time_delta(struct xdr_stream *xdr, uint32_t *bitmap,
 		status = decode_attr_time(xdr, time);
 		bitmap[1] &= ~FATTR4_WORD1_TIME_DELTA;
 	}
-	dprintk("%s: time_delta=%ld %ld\n", __func__, (long)time->tv_sec,
-		(long)time->tv_nsec);
+	dprintk("%s: time_delta=%lld %ld\n", __func__, time->tv_sec,
+		time->tv_nsec);
 	return status;
 }
 
@@ -4197,7 +4197,7 @@ static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, str
 			status = NFS_ATTR_FATTR_MTIME;
 		bitmap[1] &= ~FATTR4_WORD1_TIME_MODIFY;
 	}
-	dprintk("%s: mtime=%ld\n", __func__, (long)time->tv_sec);
+	dprintk("%s: mtime=%lld\n", __func__, time->tv_sec);
 	return status;
 }
 
-- 
2.20.0

