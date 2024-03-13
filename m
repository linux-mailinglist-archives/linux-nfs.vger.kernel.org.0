Return-Path: <linux-nfs+bounces-2282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15EE87AADC
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 17:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACF7285455
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC37481BE;
	Wed, 13 Mar 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyLJmRlw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298947F54
	for <linux-nfs@vger.kernel.org>; Wed, 13 Mar 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345837; cv=none; b=Sx2kHez+1MT2wOigkLfheNC0BmdOekya0xSmta8m4imYMnvmwHcNi/x+WDL7kMcfknMHxAQ+VIABXIfVdb85A95OVOvYqDF5Eyn0vbBwB+T1a/L+WHzJdVBIeGsYfyPBl9DWS1SgX3hVX5AvHJnUM+6CxYGYA7F4jiXCEQnsYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345837; c=relaxed/simple;
	bh=b12CHEw5tyPtmrx+mtOwg+gwWSIt2FMREAh6A+Vi2A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZW4pgsE41+hJ1vO/mXKrTBoX2TC74gUc7P+Mm0QNoDPhC6sjcDjEUpx6GhkH/bxiflNmFFCTCh4DhmzaXNgRaU3RdSJEOnIiCjWErbwA5pAFpU8FeNBmOZ3q65dSh4+wigPmvSLeggukM4OqTBOTFPbd4/fElutNaSg8Rtvxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyLJmRlw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710345834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaSe4NlsKW/FcpQSpKGI0zyNl+OeH/tBkLH23i842Ls=;
	b=ZyLJmRlwLQcYxvz7kBkA4EVN8Fg7E/3peZVcLVh0G6pwNwGjmkP4pW8jM1wHrz7VfXzIBM
	NjEhAQTgwMviA84kYc4wpr/k+AADV/eZO4a2QAwLw5RPuXeuBVyWopph/UJs4ayLrmfWmE
	Fru6HDd3IsHlmz7v+42vF9A3mch88TQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-zKkx6OuxMEOLi4hU23v98A-1; Wed, 13 Mar 2024 12:03:53 -0400
X-MC-Unique: zKkx6OuxMEOLi4hU23v98A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6680A8007A7;
	Wed, 13 Mar 2024 16:03:37 +0000 (UTC)
Received: from [100.115.132.116] (unknown [10.22.48.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03D2F2166AE4;
	Wed, 13 Mar 2024 16:03:36 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Linux /proc/fs/nfsd/clients/*/info - where does
 "Implementation name" come from ?
Date: Wed, 13 Mar 2024 12:03:35 -0400
Message-ID: <DAED4D62-A637-4796-87F2-C9BF67FD0008@redhat.com>
In-Reply-To: <CAKAoaQnzM9VqvW0FddRzKhPKHvEWV4RKfSbuX939kR83ZbzapQ@mail.gmail.com>
References: <CAKAoaQnzM9VqvW0FddRzKhPKHvEWV4RKfSbuX939kR83ZbzapQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 13 Mar 2024, at 10:51, Roland Mainz wrote:

> Hi!
>
> ----
>
> While debugging a NFSv4.1 problem I noticed that the Linux nfsd
> somehow gets a "Implementation name" /proc/fs/nfsd/clients/*/info
> files:
>
> Example:
> ---- snip ----
> $ cat /proc/fs/nfsd/clients/3/info
> clientid: 0x22d7004e65f1b8d3
> address: "104.102.54.63:666"
> status: confirmed
> seconds from last renew: 15
> name: "Linux NFSv4.2 DERGINB0666"
> minor version: 2
> Implementation domain: "kernel.org"
> Implementation name: "Linux 5.10.0-22-rt-686-pae #1 SMP PREEMPT_RT
> Debian 5.10.178-3 (2023-04-22) i686"
> Implementation time: [0, 0]
> callback state: UP
> callback address: 93.240.185.34:0
> ---- snip ----
>
> How is this implemented, e.g. what does a NFSv4.1 client have to do to
> send the nfsd a "Implementation name" string ?

This is the Linux NFS developer's mailing list, but your question is about
how to look up something in the specifications.  That's probably more
appropriate for the IETF mailing list, but you shouldn't even have to ask
anyone.  Instead, look it up in the spec.

Aren't you folks working on an implementation, and shouldn't you be up to
your ears in the spec?  Isn't it easier to just look instead of waiting on
other people to do it for you?

The answer is eia_client_impl_id, in rfc-8881.

Questions like this are annoying me, and you risk losing visibility from folks
that might also be annoyed.

https://datatracker.ietf.org/wg/nfsv4/documents/

Ben


