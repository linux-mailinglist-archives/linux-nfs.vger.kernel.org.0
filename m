Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341F6DB215
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406500AbfJQQOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 12:14:47 -0400
Received: from fieldses.org ([173.255.197.46]:37462 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404628AbfJQQOr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 12:14:47 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C9D8F1B96; Thu, 17 Oct 2019 12:14:46 -0400 (EDT)
Date:   Thu, 17 Oct 2019 12:14:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Message-ID: <20191017161446.GI32141@fieldses.org>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org>
 <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191017152253.GG32141@fieldses.org>
 <YQBPR0101MB16529BDA6C8D0949B3555C03DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQBPR0101MB16529BDA6C8D0949B3555C03DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 17, 2019 at 03:55:28PM +0000, Rick Macklem wrote:
> ps: When I re-read it, the comment I made related to Bruce's "wrong"
> was blunt (or maybe rude).

It's OK!  I'm possibly being annoying about this kinda trivial thing
anyway.

> I apologize for the tone. All I had intended to say was "although it
> might not be our preferred semantic, it appears to clear and
> implementable, so I do not think it can be "clarified" to be the way
> the Linux server does it". I actually prefer the way the Linux server
> does it, but it is too late now, imho.

For the COPY case at least, implementations seem to be rare and new.

Is it really that trivial to fix up the mismatch?

Actually, I guess so: if I'm implementing the copy using read and write,
then a 0-length read result from a nonzero read call can only mean end
of file, so there's no need to do a second check of the file length or
anything.

Hm.

--b.
