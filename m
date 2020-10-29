Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2842229F694
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 22:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJ2VGL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Oct 2020 17:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgJ2VGL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Oct 2020 17:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604005570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BiH+nNS49JKY1pLZETXPHnXoQJgcMCiXtUCPSATdp/0=;
        b=QT0a8A7rEDX9rNFAvF1LXDFpRptZDRbG00Oh1MFQ9wN+hAQ6I4gY0PFtyrHG92msie0mGU
        y0MkHwSM+oRsdx0+EOy9lAfhHMZB3T+Z4kkfzUMmV97qe/8Zm9sjwJOW4gsr+68nEVmvOF
        sAV3Vgwpv3Jk/sgMXGoQATdGlFZrqbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-lFeDDoi3OtyCLDHjm-hG0A-1; Thu, 29 Oct 2020 17:04:05 -0400
X-MC-Unique: lFeDDoi3OtyCLDHjm-hG0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2615F1084D60
        for <linux-nfs@vger.kernel.org>; Thu, 29 Oct 2020 21:04:04 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D976C5C22D
        for <linux-nfs@vger.kernel.org>; Thu, 29 Oct 2020 21:04:03 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [RFC PATCH 0/1] Enable config.d directory to be processed.
Date:   Thu, 29 Oct 2020 17:04:00 -0400
Message-Id: <20201029210401.446244-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following patch looks for config.d directories
and configuration file in those directories will
be loaded. 

For example if /etc/nfs.conf.d or /etc/nfsmount.conf.d 
exists and there are config files in those directories 
will be loaded, but not the actual /etc/nfs.conf or 
the /etc/nfsmount.conf files will not be.

I do have a couple questions/concerns 

1) Is calling conf_load_file() more than once
   kosher... It appears variable will just be 
   over written. That does appear to happen
   with my testing. 

2) If conf.d file(s) do exist, should the give
   flat conf file also be loaded. At this point if 
   the conf.d file(s) do exist, then the given
   flat config file is not loaded. 

3) How to document this new feature.

Steve Dickson (1):
  conffile: process config.d directory config files.

 support/nfs/conffile.c | 78 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

-- 
2.26.2

