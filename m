Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E098915F87F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbgBNVMa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:30 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:45024 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgBNVMa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:30 -0500
Received: by mail-yw1-f47.google.com with SMTP id t141so4866570ywc.11
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHhdjNiE93etGjkSJBkiKCvDNlNFpWtO3OwixKNX+wg=;
        b=SvKyvZA2WcHs4gWlVnoeCH1c4PT5Qsd1dV1kwzJknUzONOsLVwsyAklBhTY974gEkK
         eEznq6wQ1+13icJuOEb7KUVQFTdaFeTPHcx2TOrDGNKEv5tNNLPdFR+Cv06g3+IYA9eS
         T9p4OJHn0NmKFDxAU6C881zR1TnI6ky12gv5OOXQwedVp+2+sHf4fntsfjO6c+kOIBVp
         PBbXBxlaCGl7Otu8nMH8vnOzme2tYagHX1dFKKt7GzBymSGqw5nzUZ67C4WQsJoN8aL6
         LWv6rMExleN5oUBWfsSH5jG+WXlBjuSRHImgTFEKXY/04Me9YAYI1d+EtBxpOwGs00Wg
         +V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XHhdjNiE93etGjkSJBkiKCvDNlNFpWtO3OwixKNX+wg=;
        b=JbCCPHW333WH6b2ogvhs6WZLffLSkrJy6y57gGxJQfQB044a2SetTHndYa0iDn8MPq
         mwObpXq0Rw29KaS9cvnZfDKSGi/EiSKH1PRhCIgdGWulUHJFk9WnIxUI8SEoQ3iwkgA9
         0T5qhe8OFmSvpxCLcPSNNtkmP9aLKlJccxCndUZImnS19ek2klPOgDmGTx0rtdU8Px7K
         RFR8gD/RzGDbY+FvYTH7mlX6lCEeb8AqVrJNyEONqdARZ2xF7oBLcV9R0VK55lohshhw
         gb+hpz4LR5IbLcBXAnxLgiA0kosCF5sVhblULHemCn9gYgAtDT0lapjcCvJNJ7+bhrwO
         sV4A==
X-Gm-Message-State: APjAAAVhrmPlRUPx97ZeuxQa4vIiHJI8ioEm3l6hYpxXMV0rhPkCSSPn
        NSka7/c1v4cqGA36jhmexlN+gadH
X-Google-Smtp-Source: APXvYqzKy7d5vUjClZvIQBFf6NUDZWZTQ+lOM9jvot2SbdzQ/9AIuuIiop5K6kCxcY7JouRaf6DP9g==
X-Received: by 2002:a0d:ebcf:: with SMTP id u198mr3612802ywe.184.1581714748771;
        Fri, 14 Feb 2020 13:12:28 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z2sm2840636ywb.13.2020.02.14.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:28 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 0/6] NFS: Add support for the v4.2 READ_PLUS operation
Date:   Fri, 14 Feb 2020 16:12:21 -0500
Message-Id: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
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


Changes since v1:
- Rebase to 5.6-rc1
- Drop the mount option patch for now
- Fix fallback to READ when the server doesn't support READ_PLUS

Any questions?
Anna


Anna Schumaker (6):
  SUNRPC: Split out a function for setting current page
  SUNRPC: Add the ability to expand holes in data pages
  SUNRPC: Add the ability to shift data to a specific offset
  NFS: Add READ_PLUS data segment support
  NFS: Add READ_PLUS hole segment decoding
  NFS: Decode multiple READ_PLUS segments

 fs/nfs/nfs42xdr.c          | 169 +++++++++++++++++++++++++
 fs/nfs/nfs4proc.c          |  43 ++++++-
 fs/nfs/nfs4xdr.c           |   1 +
 include/linux/nfs4.h       |   2 +-
 include/linux/nfs_fs_sb.h  |   1 +
 include/linux/nfs_xdr.h    |   2 +-
 include/linux/sunrpc/xdr.h |   2 +
 net/sunrpc/xdr.c           | 244 ++++++++++++++++++++++++++++++++++++-
 8 files changed, 457 insertions(+), 7 deletions(-)

-- 
2.25.0

