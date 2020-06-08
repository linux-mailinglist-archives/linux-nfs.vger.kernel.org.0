Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C11F1DB9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgFHQrr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 12:47:47 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:64650 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgFHQrq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 12:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591634866; x=1623170866;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=6BFKrnEvsrYJwHC8jQDRxHqJh7RXLNVZOSuIzrtDdrY=;
  b=bPmjOb0COfa5HodbvwPaDclTqj++sKPeo6jfm1J8hzD/Hnta/pZqSDcJ
   GXdJA/tesVfqBOHv3KVtMxsWBpWuk2fKePlq3RXsxQRASYhXW+SdeVHYE
   9HL19puCvpcQ7Ek0D8kRIfBY6earYCTt2i5VV51/N3qo+bQTKpTsWZuHC
   Y=;
IronPort-SDR: 37tGz70qXmWyJ4I14fo4dRMeTn5yk6TktcL3wpVX/66VfAIENKujhqsIi6CLJJUUPSMJBFiABD
 VAnZ39pWafyQ==
X-IronPort-AV: E=Sophos;i="5.73,487,1583193600"; 
   d="scan'208";a="35107994"
Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 08 Jun 2020 16:47:45 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id C121BA0758;
        Mon,  8 Jun 2020 16:47:43 +0000 (UTC)
Received: from EX13D10UEA001.ant.amazon.com (10.43.61.5) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 16:47:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D10UEA001.ant.amazon.com (10.43.61.5) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Jun 2020 16:47:43 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 8 Jun 2020 16:47:43 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id CE65AC13F1; Mon,  8 Jun 2020 16:47:42 +0000 (UTC)
Date:   Mon, 8 Jun 2020 16:47:42 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <20200608164742.GA14076@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
 <1885904737.8217161.1585249393750.JavaMail.zimbra@desy.de>
 <20200326231602.GA29187@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <2042449942.8269597.1585295495366.JavaMail.zimbra@desy.de>
 <v2aze7-yqvuvfuc4i30-1xxisr-dr39sbpkxym7-2nbcltx37gs3ezoql-qoc5f45hvih45iurdv-lqtdu9ppbm6i-upakk-2awl3v-em4ktl4ip5gchvuicg-vgnve1-wbqe5p-fw96bj-ct2sjj-wlbpk7.1586002736523@email.android.com>
 <1684380491.969626.1591631520724.JavaMail.zimbra@desy.de>
 <CAFX2JfkeJ=rqLkt6ce2GsLqmEx2H738skH9GUwVtRPCEyTfo9Q@mail.gmail.com>
 <743392222.977980.1591634249190.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <743392222.977980.1591634249190.JavaMail.zimbra@desy.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 08, 2020 at 06:37:29PM +0200, Mkrtchyan, Tigran wrote:
> Thanks for clarification.
> 
> Tigran.
> 
> ----- Original Message -----
> > From: "Anna Schumaker" <anna.schumaker@netapp.com>
> > To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> > Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust" <trond.myklebust@hammerspace.com>, "Frank van der Linden"
> > <fllinden@amazon.com>
> > Sent: Monday, June 8, 2020 6:15:06 PM
> > Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
> 
> > Hi Tigran,
> >
> >
> > On Mon, Jun 8, 2020 at 11:59 AM Mkrtchyan, Tigran
> > <tigran.mkrtchyan@desy.de> wrote:
> >>
> >>
> >> Dear maintainers,
> >>
> >> are those changes considered for 5.8?
> >
> > My understanding is that these patches will be targeting 5.9.
> >
> > Anna

Hi Tigran,

Since there is one remaining open issue on the server side changes that needs
signoff from the general fs maintainers, I agreed with Bruce & Chuck to target
5.9, as the 5.8 merge window is currently already open, and all the activity
is centered around it.

For the client side, there are no open issues that were flagged, so from my
side it's all ready to go - except for me to post a v3 rebased to
the latest tree, which is easy to do.

In other words, I think it's ok for the client side to go in to 5.8, but it
probably makes more sense to have it go in to the same version as the server
side, so that's what I proposed to Anna & Trond.

- Frank
