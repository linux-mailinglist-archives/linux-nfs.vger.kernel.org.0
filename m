Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF551D5629
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2020 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOQfv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 May 2020 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbgEOQfv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 May 2020 12:35:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DFC061A0C;
        Fri, 15 May 2020 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=eOQ/VBa4Q42V4aV9l/Uj4hWGB9Uye9QeOmNKdZwF8Tc=; b=c1PAr+sglNmmpmO6FC92ZTX6Pw
        WF1050MCZGCrvS+GNEpED62uuYJvjXAXrEHaqXTmvDQqAad3IOGx8BNeQCgN+FmCd/6RhqzWi8W2k
        ekV1livERNWEGbLBIUkZ7qJdnzrO0gDff+l7CptvReyIenZ+Sr2YW6NEx37zO37djb4nyUzTa+u7v
        +nZTQDzNexI4SNxJtdKarnioPTDcAVUxTaHyUOLLNiWUDtG6ZbTfuAfUXLdmvTwULeGq5cfifUzbF
        pMTgCj7NYCkXVxr+Uto+DqLPGDDZDm8CZSO2MKSWQzTr4/wLI3OOW1kUYq+Scju5A8XJMP9cPy3aU
        fI2jSpLQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZdJI-0004a7-Sp; Fri, 15 May 2020 16:35:45 +0000
Subject: Re: linux-next: Tree for May 15 (nfs/fsinfo.c)
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
References: <20200515224219.48a50b28@canb.auug.org.au>
 <129e8dee-76c3-ba9d-e692-d145653bbaaa@infradead.org>
 <ef6274c2de9fcc2e1820db1ac8f0b7602a9fe6b0.camel@hammerspace.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de201900-c2ac-bc8e-d9c1-c18331a03a7f@infradead.org>
Date:   Fri, 15 May 2020 09:35:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ef6274c2de9fcc2e1820db1ac8f0b7602a9fe6b0.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/15/20 9:32 AM, Trond Myklebust wrote:
> Hi Randy,
> 
> On Fri, 2020-05-15 at 08:28 -0700, Randy Dunlap wrote:
>> On 5/15/20 5:42 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20200514:
>>>
>>> -----------------------------------------------------------------
>>> -----------
>>
>> on i386:
>>
>>   CC      fs/nfs/fsinfo.o
>> ../fs/nfs/fsinfo.c: In function ‘nfs_fsinfo_get_supports’:
>> ../fs/nfs/fsinfo.c:153:12: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_SIZE)
>>             ^~
>> ../fs/nfs/fsinfo.c:155:12: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>   if (server->attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
>>             ^~
>> ../fs/nfs/fsinfo.c:158:12: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE)
>>             ^~
>> ../fs/nfs/fsinfo.c:160:12: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN)
>>             ^~
>> ../fs/nfs/fsinfo.c:162:12: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>   if (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM)
>>             ^~
>> ../fs/nfs/fsinfo.c: In function ‘nfs_fsinfo_get_features’:
>> ../fs/nfs/fsinfo.c:205:12: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_CASE_INSENSITIVE)
>>             ^~
>> ../fs/nfs/fsinfo.c:207:13: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>   if ((server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE) ||
>>              ^~
>> ../fs/nfs/fsinfo.c:208:13: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>       (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN) ||
>>              ^~
>> ../fs/nfs/fsinfo.c:209:13: error: ‘const struct nfs_server’ has no
>> member named ‘attr_bitmask’
>>       (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
>>              ^~
>>
>> Full randconfig file is attached.
>>
> 
> Where is this file coming from? I'm not aware of any fs/nfs/fsinfo.c in
> the current tree or in my linux-next for 5.7, and a cursory glance is
> showing it up in Anna's linux-next for the 5.8 merge window.
> 

Hi Trond,

It's in today's linux-next.  from David Howells.

David?  (added to Cc)

-- 
~Randy

