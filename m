Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB41176FF
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2019 21:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIUGe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Dec 2019 15:06:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21959 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbfLIUGe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Dec 2019 15:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575921992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fLkXr81lxuzgLyYc3C6oIkZ9abU02NbNe3adD0GOMc=;
        b=Wg7dqdWm+yGfAJRluWXru101EBYwQtQl9itxb8ZFXPABs+EizayqN+BmuQBYXM2jQ9WSB+
        bYour0IGitqbDDKcifXDGBogeNfWLtr3ElQCGMR4Wrslq4GlGWXcNcXU/X2aZrfZME6hNP
        xWBDMdFyFRjGuN/mMVX1O4Ng3ptYmJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-lN1lE1s8MeKiIOppGVJGyg-1; Mon, 09 Dec 2019 15:06:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6850B80259E;
        Mon,  9 Dec 2019 20:06:29 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-120.phx2.redhat.com [10.3.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DF2F6F12C;
        Mon,  9 Dec 2019 20:06:28 +0000 (UTC)
Subject: Re: gssd question/patch
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyHJg4C5j72_CrCJhZ8hyzDe71Q9zw1USgmyxePg+3juZw@mail.gmail.com>
 <8c69eee5-9dc1-2a14-1bd2-cf812bdb39a4@RedHat.com>
 <CAN-5tyH-m=n2m8-qWbV-4iYJUhx4yMFz_uWUWAzYGArN5yxJaw@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <47f12fef-bf43-62d8-adda-303e3e551f36@RedHat.com>
Date:   Mon, 9 Dec 2019 15:06:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyH-m=n2m8-qWbV-4iYJUhx4yMFz_uWUWAzYGArN5yxJaw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: lN1lE1s8MeKiIOppGVJGyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/9/19 11:49 AM, Olga Kornievskaia wrote:
> Hi Steve,
> 
> On Mon, Dec 9, 2019 at 11:10 AM Steve Dickson <SteveD@redhat.com> wrote:
>>
>> Hey,
>>
>> On 12/6/19 1:29 PM, Olga Kornievskaia wrote:
>>> Hi Steve,
>>>
>>> Question: Is this an interesting failure scenario (bug) that should be
>>> fixed: client did a mount which acquired gss creds and stored in the
>>> credential cache. Then say it umounts at some point. Then for some
>>> reason the Kerberos cache is deleted (rm -f /tmp/krb5cc*). Now client
>>> mounts again. This currently fails. Because gssd uses internal cache
>>> to store creds lifetimes and thinks that tgt is still valid but then
>>> trying to acquire a service ticket it fails (since there is no tgt).
>> I'm unable reproduce the scenario....
>>
>> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
>> (as kuser) kinit kuser
>> (as kuser) touch /mnt/tmp/foobar
>> (as root) umount /mnt/tmp/
>> (as root) rm -f /tmp/krb5cc*
>> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
>> (as kuser) touch /mnt/tmp/foobar # which succeeds
>>
>> Where am I going wrong?
> 
> Not sure. Can you please post gssd verbose output?
> 
> Set up. Client kernel somewhat recent though the latest, but in
> reality doesn't matter i think
> gssd from nfs-utils commit 5a004c161ff6c671f73a92d818a502264367a896
> "gssd: daemonize earlier"
> 
> [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
> 192.168.1.72:/nfsshare /mnt
> [aglo@localhost nfs-utils]$ touch /mnt/kerberos
Is there a kinit before this?


> [aglo@localhost nfs-utils]$ sudo umount /mnt
> [aglo@localhost nfs-utils]$ sudo rm -fr /tmp/krb5cc*
> [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
> 192.168.1.72:/nfsshare /mnt
> mount.nfs: access denied by server while mounting 192.168.1.72:/nfsshare
> 
> Here's the gssd error output: If you look at 1st "INFO: Credentials in
> CC .... are good until..." is a lie as there isn't even a file there.
Here is what I'm seeing:
   https://paste.centos.org/view/9473f4a3

steved.

