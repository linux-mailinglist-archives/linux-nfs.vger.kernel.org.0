Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA31F344CC4
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 18:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhCVRGf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhCVRG2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 13:06:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7911C061574
        for <linux-nfs@vger.kernel.org>; Mon, 22 Mar 2021 10:06:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 916DC24F6; Mon, 22 Mar 2021 13:06:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 916DC24F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1616432786;
        bh=VcKAumEty+hY5tRWpynN75G0WdWb5fKgBpzEDfuFUJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5B7Mt1VXX2fARVv8PaFhBIBYaFGHwzdqQMrbuzdrgR9LTuJSR3ZC2AneNw5t6d3j
         ww8BEzCxyO8U095z92X7cnuo50TPv4GohvutdwZkPFQVnutQXr8LLVvXvPO69ju2Bu
         K/TW49u3fnVrM4ii1Ffi/2pzlXcKHjEeN1LDru8k=
Date:   Mon, 22 Mar 2021 13:06:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210322170626.GA24580@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <20210319132820.GA31533@fieldses.org>
 <87lfaieuoj.fsf@notabene.neil.brown.name>
 <20210319210922.GD31533@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319210922.GD31533@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 19, 2021 at 05:09:22PM -0400, J. Bruce Fields wrote:
> On Sat, Mar 20, 2021 at 07:48:44AM +1100, NeilBrown wrote:
> > For NFSv4.1, only the EXCHANGE_ID is duplicate.  There is only one
> > CREATE_SESSION, and that is where the client is confirmed.  So only one
> > confirmed client.
> > 
> > For NFSv4.0 bother SETCLIENTID and SETCLIENDID_CONFIRM are duplicate.
> > So maybe both clients get confirmed.  I should check that.
> 
> Drifting off topic, but I don't see how this client behavior makes
> sense.  Mount is chatty enough without the unnecessary duplication.
> Looking at the code....

I spent a little time tracing through the code and couldn't figure out
what's going on.

Just a note for the future that it'd be worth figuring out why the
client is repeating SETCLIENTID+SETCLIENTID_CONFIRM or
EXCHANGE_ID+CREATE_SESSION.  I understand why it might be needed for
trunking detection when there are multiple addresses involved, but
otherwise it seems unnecessary.

--b.
