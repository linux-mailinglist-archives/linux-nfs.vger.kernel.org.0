Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ABE24C9AA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 03:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHUBup (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 21:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHUBuo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 21:50:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59769C061385
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 18:50:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so246465pjq.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=gTt/DqiB7+U1qEhcafFnptC1ykE59nmu0T8ZOeRCsWk=;
        b=Vu3EaAeBosC+LEGS9iIkWQpds17YVl+kPw5Cx1JYz4xJlWz/UDVwYjxmw85HJBpI54
         IhcF2qmazyYzoNtbqjdo+F+Blgb5ddyyM2awxXncOvRQLmfkUT19KlVAMbJfZZSsztga
         HSp2/+tmpKjfQsRzft0P58jCgt08s5T22gi9Pk9xU+3zPf0hjfs6hqHBy2tfZ39Os2m3
         VPO1dINGJOroCXKKMfmerpEioW2e3cT3lcJ3nPwDUrMmYwtjWutbhZ+vTkCgK+3I0+z+
         IqVMKAA6o3Z5W6I/NGkZjxiRKAldoe9w3VWZVg022kWn0Aguv1wFDogPrNAPOU7rcfTs
         im6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gTt/DqiB7+U1qEhcafFnptC1ykE59nmu0T8ZOeRCsWk=;
        b=M4KbMLkmAU1c2XMl4UsKj26VwngWhVMYY7ZwEkxh9ZpJ6FKMQK59/WMOBNOS/4Cb5o
         V3wCqThIYUSQZ9kdDuo5LYrJgkTIFjLq6jY/EjfEbVEJYymlHi3VdEQHzNcdk5W+CwAL
         LP2ZN2zVXXUk9tu3PsEqhWaMeofW3avWK4HJTumX+k2d687BIihi5I/NMRCAjenyT8T9
         3tOqU/Qyh6RJIvu1Vbl0hNwCUZ0JQqy9BCHf8/ZJSvtXPPwR4CsL52ctCrfbQIFDzQDg
         hzsert76q/WkMtvgjmMyWwwjIxpVtY3y9dMEGYvIKl9RmrEQlbNm9D0tyT0QRgCCgJVe
         sO1A==
X-Gm-Message-State: AOAM5312zqnNh3q0YxASdp+LtvQNKxR6O/JmCJQYRzF11M1tGUNMNXeB
        CPEEtY2/m9kF7P8UsIEN1jM=
X-Google-Smtp-Source: ABdhPJzDOPifIwgNRDhUJ4B+NM33ilH2q8+k/tvhiJEPPktz5DhxUkrXjIplAnVfZcOXX4CjudeRyg==
X-Received: by 2002:a17:90a:ea8e:: with SMTP id h14mr575261pjz.105.1597974643960;
        Thu, 20 Aug 2020 18:50:43 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 12sm378304pfn.173.2020.08.20.18.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:50:43 -0700 (PDT)
Date:   Fri, 21 Aug 2020 09:50:36 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: 5.9 nfsd update breaks v4.2 copy_file_range
Message-ID: <20200821015036.bn3yqiiuvunfxb42@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

It's easy to reproduce by running multiple xfstests testcases on localhost
NFS shares. These testcases are:
  generic/430 generic/431 generic/432 generic/433 generic/565

This reproduces only on NFSv4.2.

Error log diff sample:

--- /dev/fd/63	2020-08-09 22:46:02.771745606 -0400
+++ results/generic/431.out.bad	2020-08-09 22:46:02.546745248 -0400
@@ -1,15 +1,22 @@
 QA output created by 431
 Create the original file and then copy
+cmp: EOF on /mnt/testdir/test-431/copy which is empty
 Original md5sums:
 ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
-ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/copy
+d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/copy
 Small copies from various points in the original file
+cmp: EOF on /mnt/testdir/test-431/a which is empty
+cmp: EOF on /mnt/testdir/test-431/b which is empty
+cmp: EOF on /mnt/testdir/test-431/c which is empty
+cmp: EOF on /mnt/testdir/test-431/d which is empty
+cmp: EOF on /mnt/testdir/test-431/e which is empty
+cmp: EOF on /mnt/testdir/test-431/f which is empty
 md5sums after small copies
 ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
-0cc175b9c0f1b6a831c399e269772661  TEST_DIR/test-431/a
-92eb5ffee6ae2fec3ad71c777531578f  TEST_DIR/test-431/b
-4a8a08f09d37b73795649038408b5f33  TEST_DIR/test-431/c
-8277e0910d750195b448797616e091ad  TEST_DIR/test-431/d
-e1671797c52e15f763380b45e841ec32  TEST_DIR/test-431/e
-2015eb238d706eceefc784742928054f  TEST_DIR/test-431/f
+d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/a
+d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/b
+d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/c
+d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/d
+d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/e
+d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/f
 d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/g

Bisecting shows the first "bad" commit is:

commit 94415b06eb8aed13481646026dc995f04a3a534a
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue Jul 7 09:28:05 2020 -0400

    nfsd4: a client's own opens needn't prevent delegations

I'm wondering if you're already aware of it, this simple report is for
your info.

Thanks.

-- 
Murphy
