Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07D81BE30B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD2Pqj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Apr 2020 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2Pqj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Apr 2020 11:46:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C34C03C1AD
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2020 08:46:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CDEE223E4; Wed, 29 Apr 2020 11:46:38 -0400 (EDT)
Date:   Wed, 29 Apr 2020 11:46:38 -0400
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Message-ID: <20200429154638.GB4799@fieldses.org>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
 <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
 <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
 <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
 <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
 <CAN-5tyFRDg7W9pt57jTzoRgL8L=0_d7gCoRiAqWQR36iny33NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFRDg7W9pt57jTzoRgL8L=0_d7gCoRiAqWQR36iny33NQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 28, 2020 at 10:12:29PM -0400, Olga Kornievskaia wrote:
> I also believe that client shouldn't be coded to a broken server. But
> in some of those cases, the client is not spec compliant, how is that
> a server bug? The case of SERVERFAULT of RESTOREFH I'm not sure what
> to make of it. I think it's more of a spec failure to address. It
> seems that server isn't allowed to fail after executing a
> non-idempotent operation but that's a hard requirement. I still think
> that client's best set of action is to ignore errors on RESTOREFH.

Maybe.  But how is a server hitting SERVERFAULT on RESTOREFH, anyway?
That's pretty weird.

--b.
