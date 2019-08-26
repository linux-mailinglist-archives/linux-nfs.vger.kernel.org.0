Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D4B9D4A0
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfHZRGj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 13:06:39 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:44227 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfHZRGj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 13:06:39 -0400
Received: by mail-io1-f52.google.com with SMTP id j4so30683942iog.11
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80Al+gPyf17RIcKd3EsMoWiHol5eOjBr2dyL/pe1OPE=;
        b=K31/1biWcx7+MbAVUBMEZIpt8fkRy/95rD9al0AErZgYgpzEQQXsqOQiHPHLG6iUUZ
         sF6CgLfbZri/e85Kx63RkiIt46N8tV2y9PQ9uOOJkWzjQHnu5C/Ah7KSfsdfEYx4/Hs9
         Miv2gv++B7lGhqje5KeR5MRaUaIm1iq5aDsOPdDW1tOxAQNEQ7bXfYGFRUSV+5MNFo6J
         onlVsVuHy4c3SDX/6/WNTEVKVMo9UasBhENxsWLn0K84Ot/2SAtiBbJw3XLvcsR79v6t
         VxIGHF1J2wvrlNeV6ZBl6CK0q0y129bZHm3OiMEovdvFzoAaZvZ8hzeKJrYkIoXtOVn0
         Yx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80Al+gPyf17RIcKd3EsMoWiHol5eOjBr2dyL/pe1OPE=;
        b=XmxaRpB7fyQHs7ApiKILd5Lzuz/LPRgrWYZwB5I416+0LLO7FlmzXmW2a9YUfWKwXH
         bjLfG60rnda4tECEFESBaddNZ7WtRZRgM5RgjbZjWp4Xg2T/bzm/HqyIH5flazZlRZz/
         RlNRfVEf42QsfQO9ZQJV1QH4/WTjAnq64tvEmyQ0gmx6tzqIeq7vDr4NIDsecuCRGcvn
         cIRGZPyYNhbNyEDIvcPAEhb1UqWMVuhuZR/Oy2KgZoUGGNQ7rtgnyF8HzC+TfGo9x5Qg
         5AkUZBGvsOC4v8QNVekwi20AJYUyrfyBuHRL7lw9DZR0gqXEzNGXBkRVxluhL0ctr8Oe
         /gVA==
X-Gm-Message-State: APjAAAVMCrGlo1lY2MAxn1MblR5Y0eQ/tEQXDz4H5stVbVv7GTUyEzwU
        XUhCFhq9DSF7sqRnsUYjOzrUZsl0iQ==
X-Google-Smtp-Source: APXvYqwCtqsfNvJyHkvXU+vXmY/5K/n/Ip+e71h3aFPhT9hJ7kINiS7RynA636M7jxeQCZ1l8p4Jmg==
X-Received: by 2002:a02:9988:: with SMTP id a8mr19125625jal.127.1566839198421;
        Mon, 26 Aug 2019 10:06:38 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c3sm19303643iot.42.2019.08.26.10.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 10:06:37 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] Clean up and fix NFS server handling of eof
Date:   Mon, 26 Aug 2019 13:03:10 -0400
Message-Id: <20190826170311.81482-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, the knfsd server assumes that a short read indicates and
end of file. That assumption is incorrect. The short read means that
either we've hit the end of file, or we've hit a read error.

In the case of a read error, the client may want to retry (as per
the implementation recommendations in RFC1813, and RFC7530), but
currently it is being told that it hit an eof.

The following patch cleans up read, and fixes the eof reporting
to the two following cases:
1) read() returns a zero length short read with no error.
2) the offset+length of the read is >= the file size.

Trond Myklebust (1):
  nfsd: Clean up nfs read eof detection

 fs/nfsd/nfs3proc.c |  9 ++-------
 fs/nfsd/nfs4xdr.c  | 11 +++--------
 fs/nfsd/nfsproc.c  |  4 +++-
 fs/nfsd/vfs.c      | 37 ++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.h      | 28 ++++++----------------------
 fs/nfsd/xdr3.h     |  2 +-
 6 files changed, 41 insertions(+), 50 deletions(-)

-- 
2.21.0

