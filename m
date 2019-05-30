Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB182FC92
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfE3NoF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 09:44:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfE3NoF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 09:44:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F090307D915;
        Thu, 30 May 2019 13:44:05 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBF165D704;
        Thu, 30 May 2019 13:44:04 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: client lookup_revalidate bug
Date:   Thu, 30 May 2019 09:44:03 -0400
Message-ID: <19F37AE9-C66F-4F2A-9048-ADC6021B1148@redhat.com>
In-Reply-To: <30D343CF-50AD-4470-84D5-C825EB00B5C9@redhat.com>
References: <D4DAB8F2-CAA7-4BC3-B0A0-4EAF5E9DE261@redhat.com>
 <458733948202ed0fddf37cbb79730b5ebdabd551.camel@hammerspace.com>
 <66FFF553-5DEE-4B49-A207-7B0D63FBAECB@redhat.com>
 <b8e9ef022cb5ec1fef01e34890c3119463b0bd4b.camel@hammerspace.com>
 <30D343CF-50AD-4470-84D5-C825EB00B5C9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 30 May 2019 13:44:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 30 May 2019, at 6:35, Benjamin Coddington wrote:

> On 29 May 2019, at 13:19, Trond Myklebust wrote:
>> On Wed, 2019-05-29 at 12:39 -0400, Benjamin Coddington wrote:
>>> On 29 May 2019, at 12:21, Trond Myklebust wrote:
>>
>> Sorry, but that's not the case, because of the abuse of the
>> nosharecache flag. You are manipulating the file on the server and
>> expecting an immediate cache invalidation. That would require
>> information that the client does not have.
>
> Yes, forget about the nosharecache flag.  Let's just assume we move 
> the file
> on the server.  The client does perform a GETATTR and sees the updated
> change_attr for the directory, but it matches the dentry's new d_time.
>
> I don't expect immediate cache invalidation; invalidation will never 
> happen
> as long as B/'s change_attr isn't bumped again.  On the client, B/foo
> dentry's d_time is the same as the change_attr for B/, and even though
> there's no file at B/foo on the server, the client will keep the B/foo
> dentry until something else bumps B/'s change_attr.
>
> Maybe I need to imagine a scenario where this matters more..
>
> But, I think that if we use the method of comparing d_time with the 
> parent's
> change_attr to determine if we need to lookup, this is a case where 
> that's
> not reliable.
>
> I'll try to come up with something as I have time to work on it since 
> I am
> getting pressure about it.  It looks to me like this behavior has been
> around for a long time.  Thanks for the look.

Takayuki Nagata points out that this behavior only happens when we have 
a
read delegation, and it seems obvious that we ought to skip lookup
revalidation if so.

Let me see if I can clarify the order of events so anyone that wishes 
can
better argue about what should happen.

Single client, NFS is mounted on /mnt

Client reads /mnt/A/foo, dentry A/foo is hashed.
Client moves /mnt/A/foo to /mnt/B/foo, dentry B/foo is hashed.
Server moves B/foo back to A/foo.
Client reads A/foo, gets a read delegation.
Client looks up B/foo, skips revalidation because it holds the read 
delegation.

Client will always return a positive lookup for both A/foo and B/foo at 
this
point.

Should this happen?  My position is no, it shouldn't.
