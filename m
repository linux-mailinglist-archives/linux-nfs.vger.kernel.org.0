Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB36DB06D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 16:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfJQOtW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 10:49:22 -0400
Received: from fieldses.org ([173.255.197.46]:37350 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfJQOtV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 10:49:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8BFE31C95; Thu, 17 Oct 2019 10:49:21 -0400 (EDT)
Date:   Thu, 17 Oct 2019 10:49:21 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Message-ID: <20191017144921.GF32141@fieldses.org>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org>
 <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB16526D76EE6A574D31EDF9DBDD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQBPR0101MB16526D76EE6A574D31EDF9DBDD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 17, 2019 at 04:43:58AM +0000, Rick Macklem wrote:
> >>On Wed, Oct 16, 2019 at 07:53:45PM +0000, Kornievskaia, Olga wrote:
> >>> On the client if VFS did read of len=0 then VFS itself we return 0,
> >>> thus this doesn't protect against other clients sending an NFS copy
> >>> with len=0.  And in NFS, receiving copy with len=0 means copy to the
> >>> end of the file. It's not implemented for any "intra" or "inter" code.
> >Are you saying that an NFSv4.2 Copy request with a ca_count == 0
> >will not work for the Linux NFSv4.2 server?
> >(I guess I'd better test this one, too.)
> Tested it and it does not work, at least for Fedora30.
> The server just returns 0 instead of doing a copy to EOF on the input file.
> I think you should implement this, although my client does not do this now.

Agreed.

--b.
