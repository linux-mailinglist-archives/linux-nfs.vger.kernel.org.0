Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3550523AB28
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgHCRAR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHCRAQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:16 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268CC06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so31686119iln.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dpevv1EGUecNqWR8wjply/nchCk81adi8uDZfiSCU4=;
        b=hEIaVIjHy+iRuzlYlMtT/7MJGnatkrkuRpcIoksuYEZmLs/Ir+wumSltZO8OHROjgK
         ygmcPuWtW13zGUv6KmxbjGgGiQFcxZS7qgcoZHXy9dSFSMERcqhx9G3Lm308LrnmHDJC
         1SqCsre2YhQ3oyYUFbiM+AmZLbjH+rjQt0Ek//M59D+qKXx2lW1QR0Po3CHeKoohJc/e
         NfxQYZaqM6hP6phNk9xx7xbyzJY3W5UURdyZURU10Kc2tc6Yt+dCiZWfNIayN5qkIuax
         nfRPCJ9KVoyZ8SgprCaQyw3JzjEscD7SXNK4RsoK3y0FqWcBtv4XC3IJV6J3W9uSsI65
         Tdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5dpevv1EGUecNqWR8wjply/nchCk81adi8uDZfiSCU4=;
        b=sWf8oLTymmENhTRI4iz+09EM1vdihAd50X3cWPW/UwYCROREz5C3qvwv4+FhWaWs/3
         +7+C1x7TSZZly0NodDntfci5cGSQchuknZ4WwCE+OnH+fHcwa/fAMB/nRLSdWfuD2Uo7
         +kuTl2++trNU6W/7JsXLYdtAOhV/fARGhSSrASXgVh4U1zXwRJc1wzKwVv/qCs3LkDPZ
         3YDxdnwy3oL+GOcbjeEjcEQR2pM2jv8itoLCFqQF2BeJ2JzAcd7aDgW356XEb6vtRfII
         P+qzze0FXdkIW4VH3YIywC4g8OVLUbjfWPwxx9Q447ujmc+bj30Mxl4XxpfIBBN1ILHt
         Gljg==
X-Gm-Message-State: AOAM532wS8x7j2nk4rFSR8lFl4gAaf0ZjbNuTmVmGqVLhPgfmLwRg3aR
        a1prNDbF4Ee+g8VWMXebGkr+Q+Gp
X-Google-Smtp-Source: ABdhPJw2ErPKgauYt8x9pmFYYHSRwGZaJ2aYGHTetAe054yNSQW0FFdfdgt3jIVqFal9W6q7lmfBdA==
X-Received: by 2002:a92:cbd1:: with SMTP id s17mr307102ilq.43.1596474015267;
        Mon, 03 Aug 2020 10:00:15 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:14 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 00/10] NFS: Add support for the v4.2 READ_PLUS operation
Date:   Mon,  3 Aug 2020 13:00:03 -0400
Message-Id: <20200803170013.1348350-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches add client support for the READ_PLUS operation, which
breaks read requests into several "data" and "hole" segments when
replying to the client.

Here are the results of some performance tests I ran on my own virtual
machines, which does still have the slow SEEK_HOLE/SEEK_DATA behavior.
A recent minimum-compiler-version patch makes installing newer kernels
difficult on the lab machines I have access to, but I'll still try to
collect that data since it seemed promising during my last posting
(https://www.spinics.net/lists/linux-nfs/msg76488.html).

I tested by reading various 2G files from a few different underlying
filesystems and across several NFS versions. I used the `vmtouch` utility
to make sure files were only cached when we wanted them to be. In addition
to 100% data and 100% hole cases, I also tested with files that alternate
between data and hole segments. These files have either 4K, 8K, 16K, or 32K
segment sizes and start with either data or hole segments. So the file
mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
has 32K segments beginning with a hole. The units are in seconds, with the
first number for each NFS version being the uncached read time and the second
number is for when the file is cached on the server.


          |         v3        |        v4.0       |        v4.1       |        v4.2       |
ext4      | uncached:  cached | uncached:  cached | uncached:  cached | uncached:  cached |
----------|-------------------|-------------------|-------------------|-------------------|
data      |   2.697 :   1.365 |   2.539 :   1.482 |   2.246 :   1.595 |   2.516 :   1.716 |
hole      |   2.389 :   1.480 |   1.692 :   1.444 |   1.904 :   1.539 |   1.042 :   1.005 |
mixed-4d  |   2.426 :   1.448 |   2.468 :   1.480 |   2.258 :   1.731 |   2.408 :   1.674 |
mixed-8d  |   2.446 :   1.592 |   2.497 :   1.523 |   2.240 :   1.736 |   2.179 :   1.547 |
mixed-16d |   2.608 :   1.575 |   2.446 :   1.582 |   2.330 :   1.670 |   2.192 :   1.488 |
mixed-32d |   2.544 :   1.587 |   2.164 :   1.499 |   2.076 :   1.452 |   1.982 :   1.346 |
mixed-4h  |   2.591 :   1.486 |   2.233 :   1.503 |   2.190 :   1.520 |   3.679 :   1.815 |
mixed-8h  |   2.498 :   1.547 |   2.168 :   1.510 |   2.098 :   1.511 |   2.815 :   1.484 |
mixed-16h |   2.480 :   1.664 |   2.152 :   1.597 |   2.096 :   1.537 |   2.288 :   1.580 |
mixed-32h |   2.520 :   1.467 |   2.171 :   1.496 |   2.246 :   1.593 |   2.066 :   1.389 |

          |         v3        |        v4.0       |        v4.1       |        v4.2       |
xfs       | uncached:  cached | uncached:  cached | uncached:  cached | uncached:  cached |
----------|-------------------|-------------------|-------------------|-------------------|
data      |   2.074 :   1.353 |   2.129 :   1.489 |   2.198 :   1.564 |   2.579 :   1.719 |
hole      |   1.714 :   1.430 |   1.647 :   1.440 |   1.748 :   1.464 |   1.019 :   1.028 |
mixed-4d  |   2.699 :   1.561 |   2.782 :   1.657 |   2.800 :   1.619 |   2.848 :   2.166 |
mixed-8d  |   2.204 :   1.540 |   2.346 :   1.595 |   2.356 :   1.589 |   2.335 :   1.809 |
mixed-16d |   2.034 :   1.445 |   2.212 :   1.561 |   2.172 :   1.546 |   2.127 :   1.658 |
mixed-32d |   1.982 :   1.480 |   2.135 :   1.544 |   2.136 :   1.565 |   2.024 :   1.555 |
mixed-4h  |   2.600 :   1.549 |   2.790 :   1.660 |   2.745 :   1.634 |   8.949 :   2.529 |
mixed-8h  |   2.283 :   1.555 |   2.414 :   1.605 |   2.373 :   1.607 |   5.626 :   2.015 |
mixed-16h |   2.115 :   1.512 |   2.247 :   1.593 |   2.217 :   1.608 |   3.740 :   1.803 |
mixed-32h |   2.069 :   1.499 |   2.212 :   1.582 |   2.235 :   1.631 |   2.819 :   1.542 |

          |         v3        |        v4.0       |        v4.1       |        v4.2       |
btrfs     | uncached:  cached | uncached:  cached | uncached:  cached | uncached:  cached |
----------|-------------------|-------------------|-------------------|-------------------|
data      |   2.417 :   1.317 |   2.095 :   1.445 |   2.145 :   1.523 |   2.615 :   1.713 |
hole      |   2.107 :   1.483 |   2.121 :   1.496 |   2.106 :   1.461 |   1.011 :   1.061 |
mixed-4d  |   2.348 :   1.471 |   2.370 :   1.523 |   2.379 :   1.499 |   3.028 : 225.812 |
mixed-8d  |   2.227 :   1.476 |   2.231 :   1.467 |   2.272 :   1.529 |   2.723 :  36.179 |
mixed-16d |   2.175 :   1.460 |   2.208 :   1.457 |   2.200 :   1.464 |   2.526 :  10.371 |
mixed-32d |   2.148 :   1.501 |   2.191 :   1.468 |   2.167 :   1.471 |   2.455 :   3.367 |
mixed-4h  |   2.362 :   1.561 |   2.387 :   1.513 |   2.352 :   1.536 |   5.935 :  41.494 |
mixed-8h  |   2.241 :   1.477 |   2.251 :   1.503 |   2.256 :   1.496 |   3.672 :  10.261 |
mixed-16h |   2.238 :   1.477 |   2.188 :   1.496 |   2.183 :   1.503 |   2.955 :   3.809 |
mixed-32h |   2.146 :   1.490 |   2.135 :   1.523 |   2.157 :   1.557 |   2.327 :   2.088 |


Anna Schumaker (10):
  SUNRPC: Split out a function for setting current page
  SUNRPC: Implement a xdr_page_pos() function
  NFS: Use xdr_page_pos() in NFSv4 decode_getacl()
  NFS: Add READ_PLUS data segment support
  SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
  SUNRPC: Split out _shift_data_right_tail()
  SUNRPC: Add the ability to expand holes in data pages
  NFS: Add READ_PLUS hole segment decoding
  SUNRPC: Add an xdr_align_data() function
  NFS: Decode a full READ_PLUS reply

 fs/nfs/nfs42xdr.c          | 163 ++++++++++++++++++++
 fs/nfs/nfs4proc.c          |  43 +++++-
 fs/nfs/nfs4xdr.c           |   7 +-
 include/linux/nfs4.h       |   2 +-
 include/linux/nfs_fs_sb.h  |   1 +
 include/linux/nfs_xdr.h    |   2 +-
 include/linux/sunrpc/xdr.h |   5 +
 net/sunrpc/xdr.c           | 308 ++++++++++++++++++++++++++++++++-----
 8 files changed, 482 insertions(+), 49 deletions(-)

-- 
2.27.0

