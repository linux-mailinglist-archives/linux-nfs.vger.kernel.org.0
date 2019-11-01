Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF0EC5E0
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2019 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfKAPvP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Nov 2019 11:51:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727826AbfKAPvP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Nov 2019 11:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572623474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/F/uH98yTm8/ocyS4BrLQNZoDCzFMcQkLKpDmR+yKk=;
        b=iNqAtli853y4KaqZJMkWtgA6wIvBtN7WAY9TmzM5kiIHjPzSFHR7VWMU6++e/PCjQ0kvEz
        D54SFWECqosQBe7i7ElKQ9GpsH0PEy3CAUa8XUaIJ982LgSA1uAJV8z0B4Ua4I3/v5Vl7F
        Ad2qcgpX9zgqsWyN5AABW0yVciDk5fI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-2R4BlIySO8-CwaNhv7pQGQ-1; Fri, 01 Nov 2019 11:51:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFD4800C77;
        Fri,  1 Nov 2019 15:51:09 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-124-79.rdu2.redhat.com [10.10.124.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A01F5D713;
        Fri,  1 Nov 2019 15:51:08 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 33261120054; Fri,  1 Nov 2019 11:51:06 -0400 (EDT)
Date:   Fri, 1 Nov 2019 11:51:06 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Mao Wenan <maowenan@huawei.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Dros Adamson <dros@primarydata.com>,
        jeff.layton@primarydata.com, richard.sharpe@primarydata.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: Drop LIST_HEAD where the variable it
 declares is never used.
Message-ID: <20191101155106.GA30730@pick.fieldses.org>
References: <20191101114054.50225-1-maowenan@huawei.com>
 <7E1B5E17-FF35-472B-8316-D4C01085BAE4@oracle.com>
 <20191101144921.GA10409@kadam>
MIME-Version: 1.0
In-Reply-To: <20191101144921.GA10409@kadam>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2R4BlIySO8-CwaNhv7pQGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 01, 2019 at 05:49:21PM +0300, Dan Carpenter wrote:
> On Fri, Nov 01, 2019 at 09:36:27AM -0400, Chuck Lever wrote:
> > > On Nov 1, 2019, at 7:40 AM, Mao Wenan <maowenan@huawei.com> wrote:
> > >=20
> > > The declarations were introduced with the file, but the declared
> > > variables were not used.
> > >=20
> > > Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to=
 nfsd")

Thanks, applying for 5.5.

> > I'm not sure a Fixes: tag is necessary here? 65294c1f2c5e
> > works fine without this change, and it's not something we
> > would need to backport into stable kernels.
> >=20
> > This is more of a clean up patch.
> >=20
>=20
> Fixes is not really related to backports or stable.  I would agree that
> this isn't a bug but just a cleanup, but the problem is that other
> people want Fixes tags for everything...
>=20
> Yesterday I sent a cleanup patch and I almost put the Fixes tag under
> the --- cut off but in the end I just deleted it...  It's hard to know
> what the right thing is.

It doesn't have a stable cc and it's pretty obvious cleanup, so I guess
there's no harm in it.

I could go either way.  But I'll leave the patch as is unless someone
comes up with a clear policy.

--b.

