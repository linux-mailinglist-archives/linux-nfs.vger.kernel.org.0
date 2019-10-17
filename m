Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27FEDB168
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393418AbfJQPqX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 11:46:23 -0400
Received: from p3plsmtpa06-03.prod.phx3.secureserver.net ([173.201.192.104]:60923
        "EHLO p3plsmtpa06-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392654AbfJQPqX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 11:46:23 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Oct 2019 11:46:23 EDT
Received: from [10.64.166.228] ([192.138.178.212])
        by :SMTPAUTH: with ESMTPSA
        id L7riiC7xJtyxRL7rjiZCu5; Thu, 17 Oct 2019 08:39:04 -0700
Subject: Re: NFSv4.2 server replies to Copy with length == 0
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org>
 <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191017152253.GG32141@fieldses.org>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <6f98f9ab-bf81-3a4a-64e7-2abef60e20d4@talpey.com>
Date:   Thu, 17 Oct 2019 11:39:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017152253.GG32141@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPHMT9hx650F8Fpk+be/df2CrYDZqSOinNKax1jiv5az33+Hg9NJp6J9ZgHxWGdnaPaX0dnkEXbTLr1yiTPVTA/BS16gPHwRHpZYygMqYA8dKkc9fqJ6
 BVBILh+mzhzyqxmYWAJzMdJTYoyt4Wc6Ij65YXCVDG6IfNXHNmMWjEu5iACvLxz0ZXt7NEjlL65En2ln384sQKtbRxqU+C1+w2CcsxXrho+sBWJdWqF9V+c/
 0SdosbqCvim9WHTANHHAXLooLRD7jnUS/2VHP827Ak+H75eO1EQnFQuVBN9LF5nlkuEppoAcFXMW0CGJ+jzJfg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/17/2019 11:22 AM, J. Bruce Fields wrote:
> On Thu, Oct 17, 2019 at 02:16:36AM +0000, Rick Macklem wrote:
>> I have now found two cases where the Linux NFSv4.2 server does not
>> conform to RFC-7862. One is as above and the other is a reply to Seek
>> of NFS4ERR_NXIO when the sa_offset argument == file_size (instead of
>> replying NFS_OK along with sr_eof == true).
> 
> Huh.  Looks like that's documented behavior of Linux's seek.  (See the
> ERRORS section of the lseek(2) man page.)  Looks like Solaris also
> returns -ENXIO in this case:
> 
> 	https://docs.oracle.com/cd/E26502_01/html/E29032/lseek-2.html
> 
> And freebsd too:
> 
> 	https://www.freebsd.org/cgi/man.cgi?query=lseek&sektion=2
> 
> I wonder where that spec language came from?

Those manpages look like ENXIO comes back only on sparse files. Perhaps
this is boilerplate from v4.0 before this kind of thing was common.

This should at least be discussed on nfsv4@ietf.org...

> Our NFS server could translate an -ENXIO return into 0 and sr_eof ==
> true easily enough, assuming -ENXIO is really only ever returned in that
> case.
> 
> I haven't tested, but from a quick check of the Linux client code I
> think that would require a matching fix on the client side to translate
> sr_eof == 0 *back* to ENXIO.
> 
> I don't know if it's worth it.

What Bad Thing would happen for the difference?
