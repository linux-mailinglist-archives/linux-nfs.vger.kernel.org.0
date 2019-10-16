Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646A6D9618
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfJPP6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 11:58:39 -0400
Received: from fieldses.org ([173.255.197.46]:36246 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbfJPP6j (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 11:58:39 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id ADB8B1510; Wed, 16 Oct 2019 11:58:38 -0400 (EDT)
Date:   Wed, 16 Oct 2019 11:58:38 -0400
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Message-ID: <20191016155838.GA17543@fieldses.org>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 16, 2019 at 06:22:42AM +0000, Rick Macklem wrote:
> It seems that the Copy reply with wr_count == 0 occurs when the client
> sends a Copy request with ca_src_offset beyond EOF in the input file.
> (It happened because I was testing an old/broken version of my client,
>  but I can reproduce it, if you need a bugfix to be tested. I don't know if
>  the case of ca_src_offset+ca_count beyond EOF behaves the same?)
> --> The RFC seems to require a reply of NFS4ERR_INVAL for this case.

I've never understood that INVAL requirement.  But I know it's been
discussed before, maybe there was some justification for it that I've
forgotten.

--b.

> 
> rick
> 
> ________________________________________
> From: linux-nfs-owner@vger.kernel.org <linux-nfs-owner@vger.kernel.org> on behalf of Rick Macklem <rmacklem@uoguelph.ca>
> Sent: Tuesday, October 15, 2019 10:50 PM
> To: linux-nfs@vger.kernel.org
> Subject: NFSv4.2 server replies to Copy with length == 0
> 
> During interop testing (FreeBSD client->Linux server) of NFSv4.2, my
> client got into a loop. It was because the reply to Copy was NFS_OK,
> but the length in the reply is 0.
> (I'll fix the client to fail for this case so it doesn't loop, but...)
> 
> The server is Fedora 30 (5.2.18-200 kernel version).
> It you think this might be fixed in a newer kernel or you'd like me to do
> something with it to get more info, just let me know.
> 
> I've attached a snippet of the packet trace. (If the list strips it off, just email
> me and I'll send it to you.)
> 
> rick
