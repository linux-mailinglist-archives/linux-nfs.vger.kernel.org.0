Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D7C27B379
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgI1Rmc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:42:32 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:8537 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1Rmb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601314951; x=1632850951;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=TV/oZsnagVBibGP1tFI/sDsoQP0z2z2pg/WnMqQ+1bc=;
  b=VQxRKz2xAiEMK4+Lni7flityt0O4Qk9Qz9LsNO0GqKKCzH9L/kVocnJS
   Mw8PisoCG0NIlEpHpdpwz8nvIOMEJQAdA5VehDpvMK82TO8cHWtn8NfzM
   cmzNg5Rznq2j77ZgBZYIyfOW7h0klNwLoEPIEY7fPekRN/1J/2uRTD1EV
   E=;
X-IronPort-AV: E=Sophos;i="5.77,313,1596499200"; 
   d="scan'208";a="56772636"
Subject: Re: Adventures in NFS re-exporting
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 28 Sep 2020 17:42:29 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id CD05FC0767;
        Mon, 28 Sep 2020 17:42:28 +0000 (UTC)
Received: from EX13D37UWC003.ant.amazon.com (10.43.162.183) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 28 Sep 2020 17:42:28 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D37UWC003.ant.amazon.com (10.43.162.183) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 28 Sep 2020 17:42:28 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 28 Sep 2020 17:42:27 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 2754DC138B; Mon, 28 Sep 2020 17:42:28 +0000 (UTC)
Date:   Mon, 28 Sep 2020 17:42:28 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Daire Byrne <daire@dneg.com>, Bruce Fields <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Message-ID: <20200928174228.GA31536@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200915172140.GA32632@fieldses.org>
 <2001715792.39705019.1600358470997.JavaMail.zimbra@dneg.com>
 <20200917190931.GA6858@fieldses.org>
 <20200917202303.GA29892@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <76A4DC7D-D4F7-4A17-A67D-282E8522132A@oracle.com>
 <1790619463.44171163.1600892707423.JavaMail.zimbra@dneg.com>
 <20200923210157.GA1650@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <108670779.52656705.1601110822013.JavaMail.zimbra@dneg.com>
 <20200928154949.GA14702@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B38FC84D-2658-47A6-9531-EFB6D0A64D4A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <B38FC84D-2658-47A6-9531-EFB6D0A64D4A@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 28, 2020 at 12:08:09PM -0400, Chuck Lever wrote:
> 
> 
> > On Sep 28, 2020, at 11:49 AM, Frank van der Linden <fllinden@amazon.com> wrote:
> >
> > Bruce - if you want me to 'formally' submit a version of the patch, let me
> > know. Just disabling the cache for v4, which comes down to reverting a few
> > commits, is probably simpler - I'd be able to test that too.
> 
> I'd be interested in seeing that. From what I saw, the mechanics of
> unhooking the cache from NFSv4 simply involve reverting patches, but
> there appear to be some recent changes that depend on the open
> filecache that might be difficult to deal with, like
> 
> b66ae6dd0c30 ("nfsd: Pass the nfsd_file as arguments to nfsd4_clone_file_range()")

Hm, yes, I missed nf_rwsem being added to the struct.

Probably easier to keep nfsd_file, and have v4 use just straight alloc/free
functions for it that don't touch the cache at all.

- Frank
