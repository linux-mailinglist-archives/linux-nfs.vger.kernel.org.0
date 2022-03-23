Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A214E5C19
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 00:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiCWX4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 19:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiCWX4e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 19:56:34 -0400
X-Greylist: delayed 1282 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 16:55:00 PDT
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68679496B5
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 16:55:00 -0700 (PDT)
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 22NNXN7n021638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 24 Mar 2022 10:03:24 +1030
Date:   Thu, 24 Mar 2022 10:03:23 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Message-ID: <20220323233323.GI2179@marvin.atrad.com.au>
References: <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org>
 <20220118220016.GB16108@fieldses.org>
 <20220118222050.GB30863@marvin.atrad.com.au>
 <20220118222703.GD16108@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118222703.GD16108@fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 18, 2022 at 05:27:03PM -0500, Bruce Fields wrote:
> On Wed, Jan 19, 2022 at 08:50:50AM +1030, Jonathan Woithe wrote:
> > On Tue, Jan 18, 2022 at 05:00:16PM -0500, Bruce Fields wrote:
> > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > 
> > > I thought I was iterating over the array when actually the iteration is
> > > over the values contained in the array?
> > > :
> > 
> > Would you like me to apply this against a 5.15.x kernel and test locally? 
> > Or should I just wait for a 5.15.x stable series update which includes it?
> 
> I'm pretty confident I'm reproducing the same problem you saw, so it'd
> be fine to just wait for an update.
> 
> (But if you do test these patches, let us know, one more confirmation
> never hurts.)

The shift back to a 5.15.x kernel ended up being delayed for a while for
various reasons.  The server concerned was eventually upgraded to 5.15.27 on
9 March 2022.  In that time, client machines have been turned on and off and
inevitably the conditions which caused the crash have been exercised many
times (libreoffice, firefox and thunderbird are used daily on almost all of
the clients).  The server has not experienced the crash since the upgrade. 
On the basis of this I think it's fair to consider our problem solved.

Thanks for your quick response to the report and the rapid provision of the
fix.

Regards
  jonathan
