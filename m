Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE1F0228
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2019 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbfKEQEF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Nov 2019 11:04:05 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39765 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389934AbfKEQEF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Nov 2019 11:04:05 -0500
Received: by mail-yb1-f193.google.com with SMTP id q18so9094483ybq.6
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2019 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tWsi3Ft18+lbsZPUGoUZ5CkTEseaAWdbgsy4Vs/P8Nk=;
        b=a5ogGAUivU2BqG8HbGuggPAoSn0YusPbiSdOTxY8deM8ZDPnhNZROUvpOqfTYMluVY
         hz0ZQX5sZOdpJySiLoA91wIUcL1iFOVqKrS6n+VQt0cfoIIxMpEzt/PkJ6Onxr2AqM5z
         ym9KU/mq76tOGVSg1KUpb+ea4X8WgsvG5Rh51YVq7vKgc4bgAi2i4QP76Za38NZONWpQ
         2kGRvQDH0rfP5vkRfgoH54nbL4d8ODqrnJnRcso+ZXWpR3G2Ao55GHU+NsvIv1rKu7N4
         gACDEVnRMRG/gKQT3Bf6XNKmUsFCLO5c7VLmx8i9tt5NVKtSNleCjKIWJ55gkuQFf7kU
         9nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tWsi3Ft18+lbsZPUGoUZ5CkTEseaAWdbgsy4Vs/P8Nk=;
        b=BA5zvlLP6dq/WoOcFqLlvgoqO5MQbZDdWF5q0MbAxUjDcIOmlbFLz4roBEuBeWqD9v
         w3YmVmxxJ1uTOx6QTTdjqpVkPhrkBbBujyfeB41WUTFF2YiXuxRj38VRi2tLGuo53kcj
         optF0pIkI8Les16FqKLgw9Qfk7Anoq2FSq8fI8vD/ykcO+yiJJbFjP4GHoa0B9sgp9iI
         53FNUH7D94XmTyBj5S7iNCKbTK0a3DR8uFgqZJDwEjl6wevrC5erOa5NCta3hCc6d000
         54ea9hZ12NXK5XzIT5I+WR9obfuNHlVUHxHKPtQinw/6vxh085drMj/ay/RPom4dKsNi
         d0Lw==
X-Gm-Message-State: APjAAAWUd8CQeseqU6FlOoUJqeVdsl4QdwLDJOuCb7rjGG1zifd+kNjF
        CLbJgMZDtxQpl7Yh5mPnJq02wVyAEkM=
X-Google-Smtp-Source: APXvYqwkwBiW2lvKJtrvEFeW+6b6zQa6e3m0cjDU+bQYE3p8Wx5KVMtJFyhyN1e0CDzER0fmm3vedg==
X-Received: by 2002:a25:4d09:: with SMTP id a9mr27720668ybb.131.1572969843887;
        Tue, 05 Nov 2019 08:04:03 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x136sm9493803ywd.58.2019.11.05.08.04.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 08:04:03 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xA5G41tq016745
        for <linux-nfs@vger.kernel.org>; Tue, 5 Nov 2019 16:04:02 GMT
Subject: [PATCH RFC 0/2] NFSv4 state recovery observability
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Nov 2019 11:04:01 -0500
Message-ID: <20191105160208.26481.97809.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add some trace points to the state manager to help track down common
in-the-field failures. We see "Lock reclaim failed!" a lot during
testing, for example, and want to enable our Q/A staff to capture
the failure completely and quickly.

---

Chuck Lever (2):
      NFS4: Trace state recovery operation
      NFS4: Trace lock reclaims


 fs/nfs/nfs4_fs.h   |    2 -
 fs/nfs/nfs4state.c |    4 +
 fs/nfs/nfs4trace.h |  171 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 2 deletions(-)

--
Chuck Lever
