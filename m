Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42CBD9BD8
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 22:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437166AbfJPUbv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 16:31:51 -0400
Received: from fieldses.org ([173.255.197.46]:36544 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfJPUbv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 16:31:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B2BCEBDB; Wed, 16 Oct 2019 16:31:50 -0400 (EDT)
Date:   Wed, 16 Oct 2019 16:31:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc:     Rick Macklem <rmacklem@uoguelph.ca>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Message-ID: <20191016203150.GC17543@fieldses.org>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 16, 2019 at 07:53:45PM +0000, Kornievskaia, Olga wrote:
> On 10/16/19, 11:58 AM, "J. Bruce Fields" <bfields@fieldses.org> wrote:
>     On Wed, Oct 16, 2019 at 06:22:42AM +0000, Rick Macklem wrote:
>     > It seems that the Copy reply with wr_count == 0 occurs when the
>     > client sends a Copy request with ca_src_offset beyond EOF in the
>     > input file.  (It happened because I was testing an old/broken
>     > version of my client, but I can reproduce it, if you need a
>     > bugfix to be tested. I don't know if the case of
>     > ca_src_offset+ca_count beyond EOF behaves the same?) --> The RFC
>     > seems to require a reply of NFS4ERR_INVAL for this case.
>     
>     I've never understood that INVAL requirement.  But I know it's
>     been discussed before, maybe there was some justification for it
>     that I've forgotten.
> 
> Sigh, well, I don’t know if we should consider adding the check to the
> NFS server to be NFS spec compliant. VFS layer didn't want the check
> and instead the preference has been to keep read() semantics of
> returning a short read (when the len was beyond the end of the file or
> if the source) to something beyond the end of the file.

I'm inclined to think the spec's just wrong.

And how else could a client possibly interpret a 0 return?

> On the client if VFS did read of len=0 then VFS itself we return 0,
> thus this doesn't protect against other clients sending an NFS copy
> with len=0.  And in NFS, receiving copy with len=0 means copy to the
> end of the file. It's not implemented for any "intra" or "inter" code. 

A call with len=0 sounds like a different case.

--b.
