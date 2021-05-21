Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE838CD0E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhEUSSi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 14:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231193AbhEUSSi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 14:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621621034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LACQ4lAvGOI8lAGt7YugbXaz9yYicPk6OrS88S3DQSs=;
        b=JWDxmM6giVaISTgdOwo6HIdy94lCTHOCjG37nAgzJr8smWXKJyQZ+YmrUSOQmBLTrmpUPK
        GmkL9tQel5F5qWlfzK6XznegyTNLb6Nx1ZjKcJKFCU0LCJDsZ8evyZhiqxwd3jYNDShUww
        292aBgerJ4rN86cNa/Bb/lHBDj2nqTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-1Ccvou1UNR-9rWjYZmSbaQ-1; Fri, 21 May 2021 14:17:12 -0400
X-MC-Unique: 1Ccvou1UNR-9rWjYZmSbaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB86801817;
        Fri, 21 May 2021 18:17:11 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-99.phx2.redhat.com [10.3.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63D1360D4B;
        Fri, 21 May 2021 18:17:11 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 7633F120966; Fri, 21 May 2021 14:17:10 -0400 (EDT)
Date:   Fri, 21 May 2021 14:17:10 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs 2/2] README: Add openSUSE
Message-ID: <YKf5JmJ4uRnMob5K@pick.fieldses.org>
References: <20210521060943.7223-1-pvorel@suse.cz>
 <20210521060943.7223-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521060943.7223-2-pvorel@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Both applied, thanks.--b.

On Fri, May 21, 2021 at 08:09:43AM +0200, Petr Vorel wrote:
> + sort alphabetically, improve formatting a bit
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  README | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/README b/README
> index 9093236..ddb802a 100644
> --- a/README
> +++ b/README
> @@ -3,11 +3,17 @@ the merge of what were originally two independent projects--initially
>  the 4.0 pynfs code was all moved into the nfs4.0 directory, but as time
>  passes we expect to merge the two code bases.
>  
> -Install dependent modules; on Fedora:
> -	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
> -on Debian:
> +Install dependent modules:
> +
> +* Debian
>  	apt-get install libkrb5-dev python3-dev swig python3-gssapi python3-ply
>  
> +* Fedora
> +	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
> +
> +* openSUSE
> +	zypper in install krb5-devel python3-devel swig python3-gssapi python3-ply
> +
>  You can prepare both for use with
>  	./setup.py build
>  which will create auto-generated files and compile any shared libraries
> -- 
> 2.31.1
> 

