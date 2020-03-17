Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3F1891C0
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2020 00:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgCQXDy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Mar 2020 19:03:54 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:33156 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQXDy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Mar 2020 19:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584486235; x=1616022235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ucAvYYu7/OWyWytLWFkhGyOngxUutoticaQGw8QKmSM=;
  b=nbS4RyRj7JOT7HKN/8K77jxcD4p3q/5NPW2ViNxPtnvaUnxlVptN74sT
   WR10g718xCKKYM5G2y76IIs+feHsJTT5tWCwuapKFNBqsPBfuNvsN+kzC
   B1P3ugZoP+PJs8TITwESUM+PY4pi5j10rtHbfAo2MiJ27CEvXUGLsK1Ta
   c=;
IronPort-SDR: vEfzQKWcxwfj9H3VdUgT/9vSPxhRuWZ2ebisWvEJRmiOSLi3Aq9OI+wM3rj4DopaorUYDOK1Uj
 AFzhyar3PQEg==
X-IronPort-AV: E=Sophos;i="5.70,565,1574121600"; 
   d="scan'208";a="21494060"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 17 Mar 2020 23:03:42 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id E7AD0A0699;
        Tue, 17 Mar 2020 23:03:40 +0000 (UTC)
Received: from EX13D13UEA001.ant.amazon.com (10.43.61.119) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Mar 2020 23:03:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UEA001.ant.amazon.com (10.43.61.119) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Mar 2020 23:03:40 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Tue, 17 Mar 2020 23:03:39 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9964DD8CF7; Tue, 17 Mar 2020 23:03:39 +0000 (UTC)
Date:   Tue, 17 Mar 2020 23:03:39 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] client side user xattr (RFC8276) support
Message-ID: <20200317230339.GA3130@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
 <CAFX2Jf=g2Pv62cnciB4VG6HTndJSrtfeSR_oVu9PmiBez8_Upw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=g2Pv62cnciB4VG6HTndJSrtfeSR_oVu9PmiBez8_Upw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 12, 2020 at 04:09:51PM -0400, Anna Schumaker wrote:
> I'm curious if you've tried xfstests with your patches? There are a
> handful of tests using xattrs that might be good to check with, too:
> 
> anna@gouda % grep xattr -l tests/generic/[0-9][0-9][0-9]
> tests/generic/037
> tests/generic/062
> tests/generic/066
> tests/generic/093
> tests/generic/117
> tests/generic/337
> tests/generic/377
> tests/generic/403
> tests/generic/425
> tests/generic/454
> tests/generic/489
> tests/generic/523
> tests/generic/529
> tests/generic/556
> 
> Thanks,
> Anna

I ran did a "check -nfs -g quick" run of xfstests-dev. The following tests
were applicable to extended attributes:

generic/020     fail   Doesn't compute MAX_ATTR right for NFS, passes
                       after fixing that.
generic/037     pass
generic/062     fail   It unconditionally expects the "system" and
                       "trusted" namespaces to be there too, not
                       easily fixed.
generic/066     pass
generic/093     fail   Capabilities use the "security" namespace, can't
                       work on NFS.
generic/097     fail   "trusted" namespace explicitly used, can't work
                       on NFS.
generic/103     fail   fallocate fails on NFS, not xattr related
generic/117     pass
generic/377     fail   Doesn't expect the "system.nfs4acl" attribute to
                       show up in listxattr.  Can be fixed by filtering
                       out only "user" namespace xattrs.
generic/403     fail   Uses the "trusted" namespace, but does not really
                       need it. Works if converted to the "user" namespace.
generic/454     pass
generic/523     pass


In other words, there were no problems with the patches themselves, but
xfstests will need some work to work properly.

I can send a few simple fixes in for xfstests, but a few need a bit more
work, specifically the ones that expected certain xattr namespaces to be
there. Right now there is a "_require_attr" check function, that probably
needs to be split up in to "_require_attr_user, _require_attr_system", etc
functions, which is a bit more work.

- Frank
