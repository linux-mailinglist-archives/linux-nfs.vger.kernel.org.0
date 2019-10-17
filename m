Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE5FCDB101
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 17:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391482AbfJQPWx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 11:22:53 -0400
Received: from fieldses.org ([173.255.197.46]:37404 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391285AbfJQPWx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 11:22:53 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4296F1C83; Thu, 17 Oct 2019 11:22:53 -0400 (EDT)
Date:   Thu, 17 Oct 2019 11:22:53 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Message-ID: <20191017152253.GG32141@fieldses.org>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org>
 <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 17, 2019 at 02:16:36AM +0000, Rick Macklem wrote:
> I have now found two cases where the Linux NFSv4.2 server does not
> conform to RFC-7862. One is as above and the other is a reply to Seek
> of NFS4ERR_NXIO when the sa_offset argument == file_size (instead of
> replying NFS_OK along with sr_eof == true).

Huh.  Looks like that's documented behavior of Linux's seek.  (See the
ERRORS section of the lseek(2) man page.)  Looks like Solaris also
returns -ENXIO in this case:

	https://docs.oracle.com/cd/E26502_01/html/E29032/lseek-2.html

And freebsd too:

	https://www.freebsd.org/cgi/man.cgi?query=lseek&sektion=2

I wonder where that spec language came from?

Our NFS server could translate an -ENXIO return into 0 and sr_eof ==
true easily enough, assuming -ENXIO is really only ever returned in that
case.

I haven't tested, but from a quick check of the Linux client code I
think that would require a matching fix on the client side to translate
sr_eof == 0 *back* to ENXIO.

I don't know if it's worth it.

--b.
