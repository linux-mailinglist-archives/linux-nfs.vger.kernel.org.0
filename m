Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95061379C5
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgAJWfl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:41 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41097 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAJWfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:41 -0500
Received: by mail-yw1-f67.google.com with SMTP id l22so1317217ywc.8
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xomw3E/NsXHKeYeg3B4mm0cXn6wyounmWrTrwwJvKI=;
        b=A3Y566ozmmdrRILG88EYR4kX/u8Me53vVmZsdGKkwHYdly4J64S9CMAryZOJtrUI9q
         QfNubhtkJM6O8vW/t5VVMUja8PfhjPGes0UJD5wllbjy9J/tXCW624UBNgw8rifjXuta
         de0RhLUUhuMfIdGUii9XtoPpZOngP6rUJwz2Nz8/vHOfInp2vko5yIUPddQc83GhY9fi
         B+rI/en8f1UrAx8wNwSCiv4NGQwpJU37M5X7r1rUWqNMz6YXi78gvkN+qaTM4EzWQQ/J
         XONGwlJ/JT6qStUeYCzGWbcfeNLPRDJXhwPT4O2Pwe+yZDiiqj1ZygmEnGGXpSZeKNUU
         EMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3xomw3E/NsXHKeYeg3B4mm0cXn6wyounmWrTrwwJvKI=;
        b=EI55E5lfquI4ioQDL6QV9AXhtjKJsDEt8907/SHQ+8i9jpyqekSF3tIYDjQC46U1yp
         Tq3XBh7ZlvPGKmrrCVMKFoRyUzbUNNTu02E1GR3yS/jHEI4eIJS8Kdj4zcHNKtYmOkk3
         lCl2P42/FXOa6zDKbHC89LzASbfK6oITRPzt1j2myefYRc/XGsNC3gbBd8QIftpnAR+/
         /y/SoNuKZqU5tcEFFCVEdEBkG0thZE6Y6AIRGZp3gOqPC2WMDODvWJeuu2ToHggG7kFm
         w3j5+wcEyaiv0PfCnP+vnzPos1SZuo5R4kCx2pllRhw68QwWPkbRvp2Deb+6yg13M+oC
         Dh1A==
X-Gm-Message-State: APjAAAVf2cVbZUOMNjrOBzhnC9YySoBnsE1akhBc0xZDiddF0SLC7Zyp
        NPdj9e6RgQ8fFNJ9CfPlDlU83xBdkY0=
X-Google-Smtp-Source: APXvYqzqtfCFXsSA1quBLpDOuwvtG3Nlkp05FvTGVwe3WnPtOXyqsjzoJTYA+csCrRjjk8uPdd17kg==
X-Received: by 2002:a81:a802:: with SMTP id f2mr4618346ywh.90.1578695740439;
        Fri, 10 Jan 2020 14:35:40 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id h23sm1607735ywc.105.2020.01.10.14.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:39 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 0/4] NFSD: Add support for the v4.2 READ_PLUS operation
Date:   Fri, 10 Jan 2020 17:35:34 -0500
Message-Id: <20200110223538.528560-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches add server support for the READ_PLUS operation, which
breaks read requests into several "data" and "hole" segments when
replying to the client.

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

Anna Schumaker (4):
  NFSD: Return eof and maxcount to nfsd4_encode_read()
  NFSD: Add READ_PLUS data support
  NFSD: Add READ_PLUS hole segment encoding
  NFSD: Encode a full READ_PLUS reply

 fs/nfsd/nfs4proc.c |  17 ++++
 fs/nfsd/nfs4xdr.c  | 202 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 183 insertions(+), 36 deletions(-)

-- 
2.24.1

