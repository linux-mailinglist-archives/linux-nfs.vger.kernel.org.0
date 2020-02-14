Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE615D997
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBNOeS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 09:34:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNOeS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 09:34:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so4693881pgb.10
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 06:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=z6ztcZCd4PueiOM6CfLWzdGUOWhSSHDelT8aqOratro=;
        b=I1y5jjSjMpMT0f9lyLZLKiU8HrVnOdKYjfwQ2ONsj6zRcA3bL0CLwjDlaMjINepam6
         IKXI1gUJuiwt0uM1o2I2pVau4fGIYrV5wddNjxBXrcXooHP2ml+t4XmA6fZ2Y25fX22+
         n1bqyZPlVSHxd0nuIQCcURL8d4v3qQTeDHcK9I6UeWwJOvSrzU3ztSzgnunq+WtbCq4R
         r4apvDv7awts06YIkBmeJnSZmQnnyvMlOM84g8XIIbsQ8QRdslqzAwGgPLV7oJKaLrli
         evdGDoD6SnZ0Qa8fsbvcxC91rozoIYAP8xT2RBUbroG+gQ+xIvqo+wEyObdT5VjBW8Jn
         IPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=z6ztcZCd4PueiOM6CfLWzdGUOWhSSHDelT8aqOratro=;
        b=qPItRT/tlw5sW46z7d9UJi6LxfPlRbsyXQ4Zenk5A6k9C5Yd02QGH+KVm+VRxzKcae
         oRFzdABDr+dATahU97ymufVn/bUCNGOR1B/4+O9IZDL8PvayTGiHgNoExJ9jVFblNO+k
         8720JMqXg2vy1yeULRs/4AmfuZMZREcQY4iHTblTHcBDX91xKTGf97Nu1NHbS8rV96kr
         ow/vuOCpwOEURLwmnaJILsQ/tIm2mQ2zPBo3MHuCjWbMyM5jb8ECJp/POWnTtXjAUCV/
         5Z5xBh/Tf5APqTX/9EbddjBcP2sMkHXPNV+ePnIHh5njf2R80x0jNOhzE/Su9b82+zqb
         RvWA==
X-Gm-Message-State: APjAAAWnFLmp0qfXnFYgONaBlwK8Qjflo+rRNG+Np5VfXqJlRRdzimha
        VMBx4bfO7Ume8gG65B1guuJBqYzm
X-Google-Smtp-Source: APXvYqxRHfX1eGAenga2q1EyEyX5ODGo7kntT0U2PGSEYqVGbnC0Dsm/EktsxnSmBF9pYwZaXKCcLA==
X-Received: by 2002:a65:40c8:: with SMTP id u8mr495698pgp.188.1581690856656;
        Fri, 14 Feb 2020 06:34:16 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z29sm7545274pgc.21.2020.02.14.06.34.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:34:16 -0800 (PST)
Date:   Fri, 14 Feb 2020 22:34:09 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.2: error out when relink swapfile
Message-ID: <20200214143409.27etgp3gpvv7vgsz@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This fixes xfstests generic/356 failure on NFSv4.2.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/nfs/nfs4file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index be4eb72..993a4f0 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -253,6 +253,9 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
+	if (IS_SWAPFILE(dst_inode) || IS_SWAPFILE(src_inode))
+		return -ETXTBSY;
+
 	/* check alignment w.r.t. clone_blksize */
 	ret = -EINVAL;
 	if (bs) {
-- 
1.8.3.1

