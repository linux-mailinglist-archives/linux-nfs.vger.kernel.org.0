Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBF2FA56
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfE3KfI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 06:35:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3KfI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 06:35:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A4E73179B51;
        Thu, 30 May 2019 10:35:08 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC25E10018F9;
        Thu, 30 May 2019 10:35:07 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: client lookup_revalidate bug
Date:   Thu, 30 May 2019 06:35:06 -0400
Message-ID: <30D343CF-50AD-4470-84D5-C825EB00B5C9@redhat.com>
In-Reply-To: <b8e9ef022cb5ec1fef01e34890c3119463b0bd4b.camel@hammerspace.com>
References: <D4DAB8F2-CAA7-4BC3-B0A0-4EAF5E9DE261@redhat.com>
 <458733948202ed0fddf37cbb79730b5ebdabd551.camel@hammerspace.com>
 <66FFF553-5DEE-4B49-A207-7B0D63FBAECB@redhat.com>
 <b8e9ef022cb5ec1fef01e34890c3119463b0bd4b.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 30 May 2019 10:35:08 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29 May 2019, at 13:19, Trond Myklebust wrote:
> On Wed, 2019-05-29 at 12:39 -0400, Benjamin Coddington wrote:
>> On 29 May 2019, at 12:21, Trond Myklebust wrote:
>
> Sorry, but that's not the case, because of the abuse of the
> nosharecache flag. You are manipulating the file on the server and
> expecting an immediate cache invalidation. That would require
> information that the client does not have.

Yes, forget about the nosharecache flag.  Let's just assume we move the file
on the server.  The client does perform a GETATTR and sees the updated
change_attr for the directory, but it matches the dentry's new d_time.

I don't expect immediate cache invalidation; invalidation will never happen
as long as B/'s change_attr isn't bumped again.  On the client, B/foo
dentry's d_time is the same as the change_attr for B/, and even though
there's no file at B/foo on the server, the client will keep the B/foo
dentry until something else bumps B/'s change_attr.

Maybe I need to imagine a scenario where this matters more..

But, I think that if we use the method of comparing d_time with the parent's
change_attr to determine if we need to lookup, this is a case where that's
not reliable.

I'll try to come up with something as I have time to work on it since I am
getting pressure about it.  It looks to me like this behavior has been
around for a long time.  Thanks for the look.

Ben

