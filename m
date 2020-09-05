Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804EB25E918
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Sep 2020 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgIEQoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Sep 2020 12:44:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbgIEQoU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Sep 2020 12:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599324259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QNZ7hmbQPCvS1IzhYJNpwhQpoqmNkQhRT7G0neZlYM=;
        b=V8VMuii1Ln+cCNbiVmUyyeeaUJm9oA8y5MAD0g+vAYJkx4le1TZvo77pOUbX7cE2MQ6sTL
        M73AIzHX0oLqrZUB92a/5Yik0EecgF9sSNWgUupV3/8TbwE2manhHd4nzv9ysJwFi9nv2k
        Ii9FzyTwAIDhBkO4egHQKsYnS0S3Olo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-NJOjEsk2Pqyde55v7lbdgw-1; Sat, 05 Sep 2020 12:44:15 -0400
X-MC-Unique: NJOjEsk2Pqyde55v7lbdgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE241DDE9;
        Sat,  5 Sep 2020 16:44:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-89.phx2.redhat.com [10.3.113.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 819A65D9CC;
        Sat,  5 Sep 2020 16:44:14 +0000 (UTC)
Subject: Re: idmapd Domain issue
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <80a43e48b6f0c6c8806d1f8f6ca5ed575269445f.camel@infinera.com>
 <13df4b7e-c965-6ca8-eadd-a45e9f841914@RedHat.com>
 <3d4d41bde90709f0016d37f1f60c71ad61d10e75.camel@infinera.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <a875a92d-da04-3393-f65e-4bfead9b7921@RedHat.com>
Date:   Sat, 5 Sep 2020 12:44:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3d4d41bde90709f0016d37f1f60c71ad61d10e75.camel@infinera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry for the delay.... 

On 8/10/20 10:26 AM, Joakim Tjernlund wrote:
> On Mon, 2020-08-10 at 10:13 -0400, Steve Dickson wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> On 8/8/20 6:21 AM, Joakim Tjernlund wrote:
>>> We got an old, non existing, domain configured for idmapd, like so:
>>>   Domain = x.y
>>>
>>> Now I would like to change that to our new domain but I cannot
>>> change all computers using the old domain at the same time.
>>>
>>> Ideally I would like to just add the new domain and then change
>>> clients gradually as time permits.
>>>
>>> Currently idmapd does not seems to support this ?
>> I not sure if that helps... but rpc.idmapd does query DNS
>> looking for the _nfsv4idmapdomain text record...  Add
>>      _nfsv4idmapdomain IN TXT "domainname"
>>  recorded to your DNS
> 
> You mean:
>  1) Add _nfsv4idmapdomain IN TXT "x.y" to DNS
>  2) Rm all Domain = x.y idmapd conf
>  3) Change nfsv4idmapdomain IN TXT "new.com" (do I need to restart idmapd here too?)
Yes, yes and yes... That should work... 

steved.
> ?
> 
>>
>>> Could multiple domains be added ?
>> Patches are always welcome! ;-) But I don't see
>> how the would ever work and its probably break
>> a few specs.
> 
> They didn't consider rename migration when those specs where written :)
> 
>  Jocke
> 
>>
>> steved.
>>>
>>>  Jocke
>>>
>>
> 

