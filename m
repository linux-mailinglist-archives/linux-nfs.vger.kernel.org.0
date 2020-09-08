Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69626153F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgIHQ1K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495EDC061573
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:26:02 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so17758384ioe.5
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ro+y81ILYjo5gRCSmtNg0GyISjtWC1xwsMS6VlFXD4=;
        b=Jed9NDWvN7P+xY2hqoo3varyvanMi20MJnDAb/MKq9kz46xWD5YZ2ptzNll0wJBCwe
         6gOP3kv2ytALX5rAEh6Ej6FonbE4+NJUlknfuhTfg03syeQEIPQ3fuhG8WkiZN2L3Jxp
         MyUTMHAIhx3/Ypyfpb3OiyanGuj7MGzjFR9kguSOoGlogpDiLlrehtBaEoPoXdrLT9Hp
         iAUZhmJGFLqxYGUkCUaPGU6Nu1Y3zJig4pbiTpmQx5yzcVTcjA/GxfD4EqbxTHt+xnd5
         12ea/cuhMyfkAJiK6vYREdlu/87F+NkdNstAs+GTNyJUPLvoYwiM6IcYAQruJf9PkxO5
         uvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+Ro+y81ILYjo5gRCSmtNg0GyISjtWC1xwsMS6VlFXD4=;
        b=kQzWrNXzZntMkG/GUdLf/ZFBgAKCgO0NpK5io19DiLh0F3/eKWBK+fvuMfzCnthJzB
         F2PWhETYwpWKlbaXVYD5AzWB+gj05nr8AEXvQ5SiDqiFG5obYOuHPLccHt1HrrWmdIAe
         PTPUrr5L+1VoJSS8TzqZ+k0vulzej/anzC7zI7EwrlVtgEgqbgU/ewpf7aKhIoaY+Ape
         BTKpFYILXc3OYALnhiuaIm8FZduAJ9bfve3swDRnkZvPeyIcJqX6Iu0OUdF36JXOVjMY
         mDq3+rkwQbuNaP489dMfKsP/9oHpl+VehdagJvJahqF/wadCM5a//2k+U+h99LsPe72A
         eV7g==
X-Gm-Message-State: AOAM532f3rA22+NopbLttOh/cHqKPpzLJfcMuYxcWqTpK87J0F/l69I8
        +QLM+Z/LlHcGxG6Qx6I18sI=
X-Google-Smtp-Source: ABdhPJwaJHcT41u+ZNGSR3XLmNhjQJD6tXpJ52SwWfRSpVkr1cmIO+T2ecTJKLt5x4yAtZo7gxqtiA==
X-Received: by 2002:a6b:2c1:: with SMTP id 184mr21255882ioc.137.1599582361124;
        Tue, 08 Sep 2020 09:26:01 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v7sm10269657ilg.83.2020.09.08.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:26:00 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 0/5] NFSD: Add support for the v4.2 READ_PLUS operation
Date:   Tue,  8 Sep 2020 12:25:54 -0400
Message-Id: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
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

- Changes since v4:
  - Fix up nfsd4_read_plus_rsize() calculation
  - Return a short read if we detect the file has changed during
    encoding
  - Rebase to v5.9-rc4

Here are the results of some performance tests I ran on some lab
machines. I tested by reading various 2G files from a few different underlying
filesystems and across several NFS versions. I used the `vmtouch` utility
to make sure files were only cached when we wanted them to be. In addition
to 100% data and 100% hole cases, I also tested with files that alternate
between data and hole segments. These files have either 4K, 8K, 16K, or 32K
segment sizes and start with either data or hole segments. So the file
mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
has 32K segments beginning with a hole. The units are in seconds, with the
first number for each NFS version being the uncached read time and the second
number is for when the file is cached on the server.

I added some extra data collection (client cpu percentage and sys time),
but the extra data means I couldn't figure out a way to break this down
into a concise table. I cut out v3 and v4.0 performance numbers to get
the size down, but I kept v4.1 for comparison because it uses the same
code that v4.2 without read plus uses.


Read Plus Results (ext4):
  data
   :... v4.1 ... Uncached ... 20.540 s, 105 MB/s, 0.65 s kern, 3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 20.605 s, 104 MB/s, 0.65 s kern, 3% cpu
        :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
  hole
   :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.72 s kern,  3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern,  3% cpu
   :... v4.2 ... Uncached ...  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
        :....... Cached .....  0.845 s, 2.5 GB/s, 0.72 s kern, 85% cpu
  mixed-4d
   :... v4.1 ... Uncached ... 54.691 s,  39 MB/s, 0.75 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 51.587 s,  42 MB/s, 0.75 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
  mixed-8d
   :... v4.1 ... Uncached ... 37.072 s,  58 MB/s, 0.67 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 33.259 s,  65 MB/s, 0.68 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
  mixed-16d
   :... v4.1 ... Uncached ... 27.138 s,  79 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 23.042 s,  93 MB/s, 0.73 s kern, 3% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.66 s kern, 7% cpu
  mixed-32d
   :... v4.1 ... Uncached ... 25.326 s,  85 MB/s, 0.68 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 21.125 s, 102 MB/s, 0.69 s kern, 3% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu
  mixed-4h
   :... v4.1 ... Uncached ... 58.317 s,  37 MB/s, 0.75 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 51.878 s,  41 MB/s, 0.74 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
  mixed-8h
   :... v4.1 ... Uncached ... 36.855 s,  58 MB/s, 0.68 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
   :... v4.2 ... Uncached ... 29.457 s,  73 MB/s, 0.68 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
  mixed-16h
   :... v4.1 ... Uncached ... 26.460 s,  81 MB/s, 0.74 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 19.587 s, 110 MB/s, 0.74 s kern, 3% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
  mixed-32h
   :... v4.1 ... Uncached ... 25.495 s,  84 MB/s, 0.69 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
   :... v4.2 ... Uncached ... 17.634 s, 122 MB/s, 0.69 s kern, 3% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.68 s kern, 7% cpu



Read Plus Results (xfs):
  data
   :... v4.1 ... Uncached ... 20.230 s, 106 MB/s, 0.65 s kern, 3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 20.724 s, 104 MB/s, 0.65 s kern, 3% cpu
        :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
  hole
   :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.68 s kern,  3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern,  3% cpu
   :... v4.2 ... Uncached ...  0.904 s, 2.4 GB/s, 0.72 s kern, 79% cpu
        :....... Cached .....  0.908 s, 2.4 GB/s, 0.73 s kern, 80% cpu
  mixed-4d
   :... v4.1 ... Uncached ... 57.553 s,  37 MB/s, 0.77 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 37.162 s,  58 MB/s, 0.73 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
  mixed-8d
   :... v4.1 ... Uncached ... 36.754 s,  58 MB/s, 0.69 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 24.454 s,  88 MB/s, 0.69 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
  mixed-16d
   :... v4.1 ... Uncached ... 27.156 s,  79 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 22.934 s,  94 MB/s, 0.72 s kern, 3% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.68 s kern, 7% cpu
  mixed-32d
   :... v4.1 ... Uncached ... 27.849 s,  77 MB/s, 0.68 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
   :... v4.2 ... Uncached ... 23.670 s,  91 MB/s, 0.67 s kern, 2% cpu
        :....... Cached .....  9.139 s, 235 MB/s, 0.64 s kern, 7% cpu
  mixed-4h
   :... v4.1 ... Uncached ... 57.639 s,  37 MB/s, 0.72 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern, 3% cpu
   :... v4.2 ... Uncached ... 35.503 s,  61 MB/s, 0.72 s kern, 2% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.66 s kern, 7% cpu
  mixed-8h
   :... v4.1 ... Uncached ... 37.044 s,  58 MB/s, 0.71 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 23.779 s,  90 MB/s, 0.69 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
  mixed-16h
   :... v4.1 ... Uncached ... 27.167 s,  79 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
   :... v4.2 ... Uncached ... 19.088 s, 113 MB/s, 0.75 s kern, 3% cpu
        :....... Cached .....  9.159 s, 234 MB/s, 0.66 s kern, 7% cpu
  mixed-32h
   :... v4.1 ... Uncached ... 27.592 s,  78 MB/s, 0.71 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 19.682 s, 109 MB/s, 0.67 s kern, 3% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu



Read Plus Results (btrfs):
  data
   :... v4.1 ... Uncached ... 21.317 s, 101 MB/s, 0.63 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
   :... v4.2 ... Uncached ... 28.665 s,  75 MB/s, 0.65 s kern, 2% cpu
        :....... Cached ..... 18.253 s, 118 MB/s, 0.66 s kern, 3% cpu
  hole
   :... v4.1 ... Uncached ... 18.256 s, 118 MB/s, 0.70 s kern,  3% cpu
   :    :....... Cached ..... 18.254 s, 118 MB/s, 0.73 s kern,  4% cpu
   :... v4.2 ... Uncached ...  0.851 s, 2.5 GB/s, 0.72 s kern, 84% cpu
        :....... Cached .....  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
  mixed-4d
   :... v4.1 ... Uncached ... 56.857 s,  38 MB/s, 0.76 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
   :... v4.2 ... Uncached ... 54.455 s,  39 MB/s, 0.73 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
  mixed-8d
   :... v4.1 ... Uncached ... 36.641 s,  59 MB/s, 0.68 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 33.205 s,  65 MB/s, 0.67 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
  mixed-16d
   :... v4.1 ... Uncached ... 28.653 s,  75 MB/s, 0.72 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 25.748 s,  83 MB/s, 0.71 s kern, 2% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.64 s kern, 7% cpu
  mixed-32d
   :... v4.1 ... Uncached ... 28.886 s,  74 MB/s, 0.67 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 24.724 s,  87 MB/s, 0.74 s kern, 2% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.63 s kern, 6% cpu
  mixed-4h
   :... v4.1 ... Uncached ...  52.181 s,  41 MB/s, 0.73 s kern, 1% cpu
   :    :....... Cached .....  18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
   :... v4.2 ... Uncached ... 150.341 s,  14 MB/s, 0.72 s kern, 0% cpu
        :....... Cached .....   9.216 s, 233 MB/s, 0.63 s kern, 6% cpu
  mixed-8h
   :... v4.1 ... Uncached ... 36.945 s,  58 MB/s, 0.68 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
   :... v4.2 ... Uncached ... 79.781 s,  27 MB/s, 0.68 s kern, 0% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
  mixed-16h
   :... v4.1 ... Uncached ... 28.651 s,  75 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
   :... v4.2 ... Uncached ... 47.428 s,  45 MB/s, 0.71 s kern, 1% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
  mixed-32h
   :... v4.1 ... Uncached ... 28.618 s,  75 MB/s, 0.69 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 38.813 s,  55 MB/s, 0.67 s kern, 1% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.61 s kern, 6% cpu



Thoughts?
Anna


Anna Schumaker (5):
  SUNRPC/NFSD: Implement xdr_reserve_space_vec()
  NFSD: Add READ_PLUS data support
  NFSD: Add READ_PLUS hole segment encoding
  NFSD: Return both a hole and a data segment
  NFSD: Encode a full READ_PLUS reply

 fs/nfsd/nfs4proc.c         |  20 +++++
 fs/nfsd/nfs4xdr.c          | 173 +++++++++++++++++++++++++++++++------
 include/linux/sunrpc/xdr.h |   2 +
 net/sunrpc/xdr.c           |  45 ++++++++++
 4 files changed, 213 insertions(+), 27 deletions(-)

-- 
2.28.0

