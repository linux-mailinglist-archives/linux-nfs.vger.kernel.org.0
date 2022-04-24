Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B950D2A4
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Apr 2022 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiDXPKj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Apr 2022 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiDXPK0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Apr 2022 11:10:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929666F91
        for <linux-nfs@vger.kernel.org>; Sun, 24 Apr 2022 08:07:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6610A2085; Sun, 24 Apr 2022 11:07:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6610A2085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650812845;
        bh=zXFCjk8HvPDJxXnDMNoBRzBf2uA9PN0nX4nl/X/xwjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPRUYR76hZlRMW6EdiVVl0JVx5G9LH0sqgRfKBah3gHejDmJXTPwK91NVEzl8pY7L
         H3zPMUBmXrDnngXNJTFkAjhAPBcOCTZwgl0QtGEu9+8Z/sHuUkIqEF4W20T+p9m6cM
         hTazk7vNamUUVyC/UmnY+R7b96/DNhwiYkNk8vfk=
Date:   Sun, 24 Apr 2022 11:07:25 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Message-ID: <20220424150725.GA31051@fieldses.org>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org>
 <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 22, 2022 at 11:03:17PM +0000, Rick Macklem wrote:
> J. Bruce Fields <bfields@fieldses.org> wrote:
> > Actually (sorry I'm slow to understand this)--why would our 4.1 server
> > ever be returning STALE on a close?  We normally hold a reference to the
> > file.
> Well, OPEN_RESULT_PRESERVE_UNLINKED is not set in the Open reply,
> so even if it normally does so, it is not telling the ESXi client that it
> will retain it.

Yeah, we don't guarantee it, but I thought in this cases we did.  The
object we use to represent the open stateid (indirectly) holds a
reference on the inode that prevents it from being removed, so the
filehandle lookup should still work.  If I had the time, I'd write an
open-rename over-close test in pynfs and see if we could reproduce this,
and if so see what's happening.

> > Oh, wait, is subtree_check set on the export?  You don't want to do
> > that.  (The freebsd server probably doesn't even give that as an
> > option?)
> Nope, Never heard of it.

It adds a reference to the parent into the filehandle, so we can foil
filehandle-guessing attacks on exports of subdirectories of filesystems.
With the major drawback that it breaks on cross-directory rename, for
example.  So it's not the default.

--b.
