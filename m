Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63CD974B
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393296AbfJPQ1E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 12:27:04 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59399 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390184AbfJPQ1E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Oct 2019 12:27:04 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKm8b-0005Vr-DR; Wed, 16 Oct 2019 17:27:01 +0100
Subject: Re: [PATCH] NFSv4: add declaration of current_stateid
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@lists.codethink.co.uk,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191015121953.14905-1-ben.dooks@codethink.co.uk>
 <20191015163136.GA11160@infradead.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <63bbd39b-6f9d-f58c-4ad7-428ac4ca9d5b@codethink.co.uk>
Date:   Wed, 16 Oct 2019 17:27:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015163136.GA11160@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15/10/2019 17:31, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 01:19:53PM +0100, Ben Dooks wrote:
>> The current_stateid is exported from nfs4state.c but not
>> declared in any of the headers. Add to nfs4_fs.h to
>> remove the following warning:
> 
> I think you also need to remove the extern in pnfs.c as well.

ok, thanks, will sort.

> Also nfs4_stateid_is_current has a local variable with the same name,
> so you might want to rename that so that we don't get symbol shadowing
> warnings.
> 
ok, will do.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
