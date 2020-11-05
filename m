Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154022A81A4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgKEO4q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 09:56:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730721AbgKEO4q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 09:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604588205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CO0ef8bt9ylRv+llSmqcCxmoaQJr2ZgHJ+38avSgMFo=;
        b=QVn3mIhMwuTCQxRhIzHnXFwXAZzv+gUWk8hFb76DVYQBE12qxTM6eUm34W/0HzYv5d3wCm
        hP6+/0q34Q7fi2kcugYxaWyLsnKRyX31BO4SeuMW8u+FgH7Ng78lZw8eMlHn32QcblqiJg
        HhvnJUCt+0Pq2X61klgHS2ipeV9dZWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-I_RWUVVGM5ySZy7oabsvpA-1; Thu, 05 Nov 2020 09:56:44 -0500
X-MC-Unique: I_RWUVVGM5ySZy7oabsvpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E4E8DF0AE
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:43 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-68.phx2.redhat.com [10.3.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6E0A5D9D5
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:42 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/3 V2]  Enable config.d directory to be processed.
Date:   Thu,  5 Nov 2020 09:56:31 -0500
Message-Id: <20201105145634.98281-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here is the second attempt to use conf.d directories
to set configuration variables. 

When a conf.d directory exists and files with the
".conf" extension exist they will be used to set
configuration variables. 

Files not using that extension or files beginning 
with a "." (ex .nfs.conf) will be ignored. 

The conf.d files will take priority over the main 
config files. Meaning a variable set in both the
main config and the conf.d file, the conf.d file
will have priority over the variable in the main config.

The ordering of when the conf.d are processed
can be set by alphabetical naming convention.
Prefixing file name with a 001-nfs.conf, 
002-nfs.conf will control when the config is 
process. Note the last config file process
with have the highest priority.

Steve Dickson (3):
  conffile: process config.d directory config files.
  conffile: Only process files in the config.d dirs that end with ".conf"
  manpage: Update nfs.conf and nfsmount.conf manpages

 support/nfs/conffile.c        | 139 +++++++++++++++++++++++++++++++++-
 systemd/nfs.conf.man          |   8 ++
 utils/mount/nfsmount.conf.man |   7 ++
 3 files changed, 151 insertions(+), 3 deletions(-)

-- 
2.26.2

