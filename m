Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0212EFAF
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2020 23:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgABWrz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jan 2020 17:47:55 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40286 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbgABW2z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jan 2020 17:28:55 -0500
Received: by mail-vs1-f67.google.com with SMTP id g23so26291572vsr.7
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2020 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+IvawXxuFP1/2g9+dEu9R2Wn2HkVO4FfccJ13Xbekj8=;
        b=b8//DhrLsmC45OH9wTlgoIZnuZltguUdFNC9DrxnXMMuIjUIxJ4dk0WoI1GW6EGMCs
         qOXdNLaePdjGd0p/gnLnqBnBhk2/vNrj0fsJOK1tmYdPLFfGvNZUQohVL9tpjuBK8QMj
         POVmYhr4aUX46M3QM4au4jf6XGrTTbdG73yqhYga8c8PAgAod8cWAeE6jZc/RVb6zd72
         Fl+TzCwfyb5qn4Zu/IJIZLe1R+c1KN336eAKXrzGlQYisbQJds9mSgfS+D+Cq54Wan9p
         oKY6JopvisyT6HiyFKLhwaRexvxQsk4GMxrhcGwmcZISLV2ecri8Psotf8+cagDMw+Bk
         Dm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+IvawXxuFP1/2g9+dEu9R2Wn2HkVO4FfccJ13Xbekj8=;
        b=Jxlr1ZzqFpLXOjP1DvriZGvPjjUyl27JSaj5rLFVHhF/9fezwIAwSB6++3MmuDd5sm
         S3bewSs9n0qJ/r2OJyzcatznM7afHYckJ8lpn7OF4j2cJkVQHvY7CLsQhwMDfESCKUSA
         OdeyH+RZXuItpi8pYmT5Ic4lCN35PWXAPCrTySOKeVrFRhjQucfJqjOe5aZ6DMbrNBf5
         FNWUacLxNyU3IRqZ0DijYZwV1SaPnYY4uNc6GWhkcTF7msuQSYHbN+6bjNO8VwEo2Hrz
         +++OLOe0FsmiXDogBQt/P8LYkF28I4c+YL24d17nLytH9S2WBeQmNjNqmhfoMW5tTqae
         AYjw==
X-Gm-Message-State: APjAAAXh1WzO9w0ssVCqI0GeN+cMvYEkBMfBkqukMvt2VVWpYwvWWNpl
        I4SyF+x8QF1UHYkCq5SCc+B7mVDCeDuA0uHJf1jo+W2O
X-Google-Smtp-Source: APXvYqx5k49ro1DcSF+ngB62WUO5WcVHZgcyAS1iY+WMgFCCZyWO4utsHCWq57qkSTYhrki9zv9cgU/HYyFjoOM+Ujg=
X-Received: by 2002:a67:f81a:: with SMTP id l26mr45000725vso.194.1578004134785;
 Thu, 02 Jan 2020 14:28:54 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 2 Jan 2020 17:28:44 -0500
Message-ID: <CAN-5tyEg2b1CnbJrc-Hf2406cPWCAOjYcpPq0FremYjFXsytDQ@mail.gmail.com>
Subject: extended attributes limitation of xattr_size_max
To:     Andreas Gruenbacher <agruen@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Andreas and Bruce,

I thought of you folks as somebody who might have a strong opinion on
the topic. Right now an NFS client is limited to setting and getting
ACLs that can't be larger than 64K (XATTR_SIZE_MAX) (where some NFS
server don't have such limit on the ACL size). There are limits in
fs/xattr.c during getting and setting xattrs. I believe that's because
linux local xattr system is limited to that particular constraint.
However, an NFS acl that uses the xattr interface can be larger than
that. Is it at all possible to suggest to the larger FS community to
remove those limits or would that be a non-starter?

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f..52a3f91 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -428,8 +428,6 @@ int __vfs_setxattr_noperm(struct dentry *dentry,
const char *name,
  return error;

  if (size) {
- if (size > XATTR_SIZE_MAX)
- return -E2BIG;
  kvalue = kvmalloc(size, GFP_KERNEL);
  if (!kvalue)
  return -ENOMEM;
@@ -528,8 +526,6 @@ static int path_setxattr(const char __user *pathname,
  return error;

  if (size) {
- if (size > XATTR_SIZE_MAX)
- size = XATTR_SIZE_MAX;
  kvalue = kvzalloc(size, GFP_KERNEL);
  if (!kvalue)
  return -ENOMEM;
--
