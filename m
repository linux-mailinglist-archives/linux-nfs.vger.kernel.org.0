Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049331379BD
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgAJWe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:34:59 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35197 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgAJWe6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:34:58 -0500
Received: by mail-yw1-f66.google.com with SMTP id i190so1327734ywc.2
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqUR+C/d+RykTDqAkWYDvMDWcezrCrCm5h4JvDBhWNA=;
        b=aRvP0glczzC6DEYOaOEpRGh0fjaJi/PhXknvnwpMF2oDSSJ/N0etZ7RVKxFYM8hrQ5
         QdxH8pWxRxei/qwNuFetFWPgYJcVomSh/tQZF1eQ7aEs++GZQAw8N+qvRPub07Sv1HYl
         mRMQOcEe9t4SiPaOepy61mWWDuTRiwiFw9AfRmv3gIpqPDRUoyytcj+oEu0bLUxyUc9b
         8l1cRQX8Jvan+8YYiDTPTWZtSPGUdE/3S5tHyD3p57yOSvVstfZfx+JZDEVBVkBvKuVv
         jSfbnlF9cM5gdO7+Ve6xlEwBiYDwrlzS4vaBY36QW2j4Pj15znf46lleHcOiy4/k8u13
         SIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=iqUR+C/d+RykTDqAkWYDvMDWcezrCrCm5h4JvDBhWNA=;
        b=Kq2TgzfYmfkEvru7WRAAr1m8vC3C9A8oIstU9U7/L6G42lqCjPYLOPTm9gy9RvI28b
         HqscdAfhaH/0Htnb1sLZCc/ADoAJWio3SEgwknTueSUFlYngweuasTTLLeq7ZHpqGmML
         zzLpb6E/YKekAL6z2pgsuZby5wkfy3e2kaIEVyvDdU9d6daEIJ/Bw9Iujwj5VC/DEPax
         6P5aEQzNB+Sqb2ZOASbIpFBKxuLRG0C1EmyudrndsLbq6LUWkRwZ2G0eCKOj99FSFzJT
         hPTfZ/fidoKf5iBvIuOegjq4EqyPw8DgJRD8opVd2vvatjGaRX4ZSQRnMwqwspjDGKXn
         rVLQ==
X-Gm-Message-State: APjAAAUrG/lY3Cw3mkozDkZX5bkINSrV17fUYkjIJcIpd6+4Itc5j7jm
        dB9GcKnIrcdtqGlm38A7SvA=
X-Google-Smtp-Source: APXvYqxdev+bOHvVQmqeYYLruZWGthK5awZBPSiY9tjBEYmSfsOrekzehBj1YvffmjvImh2vTaMynQ==
X-Received: by 2002:a81:af0b:: with SMTP id n11mr4598453ywh.203.1578695697522;
        Fri, 10 Jan 2020 14:34:57 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id e186sm1554060ywb.73.2020.01.10.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:34:56 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 0/7] NFS: Add support for the v4.2 READ_PLUS operation
Date:   Fri, 10 Jan 2020 17:34:48 -0500
Message-Id: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches add client support for the READ_PLUS operation, which
breaks read requests into several "data" and "hole" segments when
replying to the client. I also add a "noreadplus" mount option to allow
users to disable the new operation if it becomes a problem, similar to
the "nordirplus" mount option that we already have.

Here are the results of some performance tests I ran on Netapp lab
machines. I tested by reading various 2G files from a few different
undelying filesystems and across several NFS versions. I used the
`vmtouch` utility to make sure files were only cached when we wanted
them to be. In addition to 100% data and 100% hole cases, I also tested
with files that alternate between data and hole segments. These files
have either 4K, 8K, 16K, or 32K segment sizes and start with either data
or hole segments. So the file mixed-4d has a 4K segment size beginning
with a data segment, but mixed-32h hase 32K segments beginning with a
hole. The units are in seconds, with the first number for each NFS
version being the uncached read time and the second number is for when
the file is cached on the server.

ext4      |        v3       |       v4.0      |       v4.1      |       v4.2      |
----------|-----------------|-----------------|-----------------|-----------------|
data      | 22.909 : 18.253 | 22.934 : 18.252 | 22.902 : 18.253 | 23.485 : 18.253 |
hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.708 :  0.709 |
mixed-4d  | 28.261 : 18.253 | 29.616 : 18.252 | 28.341 : 18.252 | 24.508 :  9.150 |
mixed-8d  | 27.956 : 18.253 | 28.404 : 18.252 | 28.320 : 18.252 | 23.967 :  9.140 |
mixed-16d | 28.172 : 18.253 | 27.946 : 18.252 | 27.627 : 18.252 | 23.043 :  9.134 |
mixed-32d | 25.350 : 18.253 | 24.406 : 18.252 | 24.384 : 18.253 | 20.698 :  9.132 |
mixed-4h  | 28.913 : 18.253 | 28.564 : 18.252 | 27.996 : 18.252 | 21.837 :  9.150 |
mixed-8h  | 28.625 : 18.253 | 27.833 : 18.252 | 27.798 : 18.253 | 21.710 :  9.140 |
mixed-16h | 27.975 : 18.253 | 27.662 : 18.252 | 27.795 : 18.253 | 20.585 :  9.134 |
mixed-32h | 25.958 : 18.253 | 25.491 : 18.252 | 24.856 : 18.252 | 21.018 :  9.132 |

xfs       |        v3       |       v4.0      |       v4.1      |       v4.2      |
----------|-----------------|-----------------|-----------------|-----------------|
data      | 22.041 : 18.253 | 22.618 : 18.252 | 23.067 : 18.253 | 23.496 : 18.253 |
hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.723 :  0.708 |
mixed-4d  | 29.417 : 18.253 | 28.503 : 18.252 | 28.671 : 18.253 | 24.957 :  9.150 |
mixed-8d  | 29.080 : 18.253 | 29.401 : 18.252 | 29.251 : 18.252 | 24.625 :  9.140 |
mixed-16d | 27.638 : 18.253 | 28.606 : 18.252 | 27.871 : 18.253 | 25.511 :  9.135 |
mixed-32d | 24.967 : 18.253 | 25.239 : 18.252 | 25.434 : 18.252 | 21.728 :  9.132 |
mixed-4h  | 34.816 : 18.253 | 36.243 : 18.252 | 35.837 : 18.252 | 32.332 :  9.150 |
mixed-8h  | 43.469 : 18.253 | 44.009 : 18.252 | 43.810 : 18.253 | 37.962 :  9.140 |
mixed-16h | 29.280 : 18.253 | 28.563 : 18.252 | 28.241 : 18.252 | 22.116 :  9.134 |
mixed-32h | 29.428 : 18.253 | 29.378 : 18.252 | 28.808 : 18.253 | 27.378 :  9.134 |

btrfs     |        v3       |       v4.0      |       v4.1      |       v4.2      |
----------|-----------------|-----------------|-----------------|-----------------|
data      | 25.547 : 18.253 | 25.053 : 18.252 | 24.209 : 18.253 | 32.121 : 18.253 |
hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.252 |  0.702 :  0.724 |
mixed-4d  | 19.016 : 18.253 | 18.822 : 18.252 | 18.955 : 18.253 | 18.697 :  9.150 |
mixed-8d  | 19.186 : 18.253 | 19.444 : 18.252 | 18.841 : 18.253 | 18.452 :  9.140 |
mixed-16d | 18.480 : 18.253 | 19.010 : 18.252 | 19.167 : 18.252 | 16.000 :  9.134 |
mixed-32d | 18.635 : 18.253 | 18.565 : 18.252 | 18.550 : 18.252 | 15.930 :  9.132 |
mixed-4h  | 19.079 : 18.253 | 18.990 : 18.252 | 19.157 : 18.253 | 27.834 :  9.150 |
mixed-8h  | 18.613 : 18.253 | 19.234 : 18.252 | 18.616 : 18.253 | 20.177 :  9.140 |
mixed-16h | 18.590 : 18.253 | 19.221 : 18.252 | 19.654 : 18.253 | 17.273 :  9.135 |
mixed-32h | 18.768 : 18.253 | 19.122 : 18.252 | 18.535 : 18.252 | 15.791 :  9.132 |

ext3      |        v3       |       v4.0      |       v4.1      |       v4.2      |
----------|-----------------|-----------------|-----------------|-----------------|
data      | 34.292 : 18.253 | 33.810 : 18.252 | 33.450 : 18.253 | 33.390 : 18.254 |
hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.718 :  0.728 |
mixed-4d  | 46.818 : 18.253 | 47.140 : 18.252 | 48.385 : 18.253 | 42.887 :  9.150 |
mixed-8d  | 58.554 : 18.253 | 59.277 : 18.252 | 59.673 : 18.253 | 56.760 :  9.140 |
mixed-16d | 44.631 : 18.253 | 44.291 : 18.252 | 44.729 : 18.253 | 40.237 :  9.135 |
mixed-32d | 39.110 : 18.253 | 38.735 : 18.252 | 38.902 : 18.252 | 35.270 :  9.132 |
mixed-4h  | 56.396 : 18.253 | 56.387 : 18.252 | 56.573 : 18.253 | 67.661 :  9.150 |
mixed-8h  | 58.483 : 18.253 | 58.484 : 18.252 | 59.099 : 18.253 | 77.958 :  9.140 |
mixed-16h | 42.511 : 18.253 | 42.338 : 18.252 | 42.356 : 18.252 | 51.805 :  9.135 |
mixed-32h | 38.419 : 18.253 | 38.504 : 18.252 | 38.643 : 18.252 | 40.411 :  9.132 |

Any questions?
Anna

Anna Schumaker (7):
  SUNRPC: Split out a function for setting current page
  SUNRPC: Add the ability to expand holes in data pages
  SUNRPC: Add the ability to shift data to a specific offset
  NFS: Add READ_PLUS data segment support
  NFS: Add READ_PLUS hole segment decoding
  NFS: Decode multiple READ_PLUS segments
  NFS: Add a mount option for READ_PLUS

 fs/nfs/fs_context.c        |  14 +++
 fs/nfs/nfs42xdr.c          | 169 +++++++++++++++++++++++++
 fs/nfs/nfs4client.c        |   3 +
 fs/nfs/nfs4proc.c          |  32 ++++-
 fs/nfs/nfs4xdr.c           |   1 +
 include/linux/nfs4.h       |   2 +-
 include/linux/nfs_fs_sb.h  |   2 +
 include/linux/nfs_xdr.h    |   2 +-
 include/linux/sunrpc/xdr.h |   2 +
 net/sunrpc/xdr.c           | 244 ++++++++++++++++++++++++++++++++++++-
 10 files changed, 464 insertions(+), 7 deletions(-)

-- 
2.24.1

