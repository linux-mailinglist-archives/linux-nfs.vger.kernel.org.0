Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE6179743
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 18:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgCDRyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 12:54:02 -0500
Received: from xes-mad.com ([162.248.234.2]:32690 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729749AbgCDRyC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Mar 2020 12:54:02 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 12:54:01 EST
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 108D5201D5
        for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2020 11:48:57 -0600 (CST)
Date:   Wed, 4 Mar 2020 11:48:57 -0600 (CST)
From:   Nate Collins <ncollins@xes-inc.com>
To:     linux-nfs@vger.kernel.org
Message-ID: <2034792133.208072.1583344137018.JavaMail.zimbra@xes-inc.com>
Subject: Question - data integrity with soft mount
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - GC80 (Linux)/8.8.15_GA_3895)
Thread-Index: hStam2BCSKz7Z3vFvwsh8i17s1C2/Q==
Thread-Topic: Question - data integrity with soft mount
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Apologies if this is the incorrect mailing list for this question.

We are configuring a server with a soft NFS mount. The mountpoint's
availability is not integral to the server's function (it holds uploaded
files), but its instability has been shown to cause worker processes to go
into an uninterruptible sleep, impacting the functionality of the server
as a whole. For this reason, we are looking to configure the mountpoint
as a soft mount with low timeo and retrans values and sync enabled,
and wanted to verify that the options we chose are sane and won't cause
any unexpected data loss/corruption. Particularly, we want to avoid a
situation where writes (uploads, in this case) are considered "OK" by
the client not written to the NFS server (in the event of instability
with the share, we are fine denying writes/uploads).

nfsstat data from existing servers with hard mounts on the network
report a retrans percentage between 0% and .00026%. The options
we have chosen for this server (previously without a mount) are
`defaults,nfsvers=3,soft,sync,timeo=5,retrans=2`. Do these seem sane
for our situation?

Any input is appreciated, thanks.
