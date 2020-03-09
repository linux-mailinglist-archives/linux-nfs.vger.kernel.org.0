Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DEF17DDFE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCIKy4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 06:54:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgCIKy4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 06:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583751295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kLpiVD9mqrElRMXZHaHmZeihqzCdUoCavXwd6TQeAq4=;
        b=K/kqbhaUYD1J5rQsbltRPVeKxi6vmXBnd7MDudGk1z3HneVqvSYfu5WW5zZb5Klvg/4fdg
        61+0V9wvTtX6k5frcATRKKqXUbmJGtxTfEEtYmFXiP/sKElw38X2mFpH6oeAcVTgDzJIrV
        qZpb1e0hYzHQZTLb4r+nVKlk7csVyPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-LBENYHAeO_ew2HE7zQXktg-1; Mon, 09 Mar 2020 06:54:53 -0400
X-MC-Unique: LBENYHAeO_ew2HE7zQXktg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B38161005514;
        Mon,  9 Mar 2020 10:54:52 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7014390CF0;
        Mon,  9 Mar 2020 10:54:52 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/2] SUNRPC: Remove xdr_buf_read_mic()
Date:   Mon, 09 Mar 2020 06:55:26 -0400
Message-ID: <AA1BA7F3-F66F-44CA-AA17-29A7D809D481@redhat.com>
In-Reply-To: <20200308181509.14148.58149.stgit@manet.1015granger.net>
References: <20200308181503.14148.29579.stgit@manet.1015granger.net>
 <20200308181509.14148.58149.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Mar 2020, at 14:15, Chuck Lever wrote:

> Clean up: this function is no longer used.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

