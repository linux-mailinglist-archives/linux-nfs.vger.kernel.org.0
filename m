Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2FD240748
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgHJONn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 10:13:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbgHJONm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 10:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597068821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHQ6GUNUNzcfdcxw7jdjHXRy05lnkQqX4ru+UXPEAog=;
        b=aPXOWTiIxX1iSu3/hYC7gtkMUdzE4Xf/maE2nzEDuPcbo7sU465HlTpuuWjx+DffCA+qGW
        Bc0oN9VQM3wFVQdJRokHsikAqSaZbSTJQv2kd5Wo1sHzzyReJgDjMqg83HAXJuG3xme6zZ
        UObix/p7MP8rEtX/7rw0GG/TwohrFi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-DUXfudd9Ppqg9ejaR5vkvA-1; Mon, 10 Aug 2020 10:13:40 -0400
X-MC-Unique: DUXfudd9Ppqg9ejaR5vkvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A7E18014D7;
        Mon, 10 Aug 2020 14:13:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-70.phx2.redhat.com [10.3.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D24FE19C4F;
        Mon, 10 Aug 2020 14:13:38 +0000 (UTC)
Subject: Re: idmapd Domain issue
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <80a43e48b6f0c6c8806d1f8f6ca5ed575269445f.camel@infinera.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <13df4b7e-c965-6ca8-eadd-a45e9f841914@RedHat.com>
Date:   Mon, 10 Aug 2020 10:13:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <80a43e48b6f0c6c8806d1f8f6ca5ed575269445f.camel@infinera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/8/20 6:21 AM, Joakim Tjernlund wrote:
> We got an old, non existing, domain configured for idmapd, like so:
>   Domain = x.y
> 
> Now I would like to change that to our new domain but I cannot
> change all computers using the old domain at the same time.
> 
> Ideally I would like to just add the new domain and then change
> clients gradually as time permits.
> 
> Currently idmapd does not seems to support this ?
I not sure if that helps... but rpc.idmapd does query DNS 
looking for the _nfsv4idmapdomain text record...  Add 
     _nfsv4idmapdomain IN TXT "domainname"
 recorded to your DNS

> Could multiple domains be added ?
Patches are always welcome! ;-) But I don't see 
how the would ever work and its probably break 
a few specs.

steved.
> 
>  Jocke
> 

