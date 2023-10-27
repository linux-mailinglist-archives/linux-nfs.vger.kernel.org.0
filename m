Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E831C7D8FC9
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjJ0H2g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 03:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0H2e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 03:28:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B14192;
        Fri, 27 Oct 2023 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8/05csco78lhslJvbFaxQUgN8P1NV2s/miTgwO3CDd0=; b=Ymw7Y0vk2yyy7FOY6UpPF3FPWp
        wpQoxwCRYKF/S1j3emXpzQSlAjBrsXtWIJLgg/kYKwBhLhDnZI5cQtMdMB25hftKeybk4WqTQJ6kV
        tVZ53NExzI7KqfTG/omuVuGcW5I34tfO39rM4LaMm3aIEEDE8KDjdcszcV+QSaQRE994XdIAT0ypG
        EncVhXIlU8vBXiOw9vVvRiU2vaNIWFzRpFmTYD5y2CCd85ZKQ+9Smsm71CTqcoLpKuZoQWWhh7SZl
        RGRJJe1JJ7fHz4zbUwhMtZM5rVdZKmUEdoN7UMHJLtkcrWcIOCIEyKliH+wyDo3NK0yefqgWGpBAF
        YkxswOSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwHGh-00Fmon-0V;
        Fri, 27 Oct 2023 07:28:31 +0000
Date:   Fri, 27 Oct 2023 00:28:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
Message-ID: <ZTtmn4o8WrU4+yHM@infradead.org>
References: <20231026192830.21288-1-rdunlap@infradead.org>
 <CAOQ4uxhYiu+ou0SiwYsuSd-YayRq+1=zgUw_2G79L8SxkDQV7g@mail.gmail.com>
 <ZTtSJYVmZ/l3d9wD@infradead.org>
 <CAOQ4uxjxTw0k33XqoEUrT6iHdOWrnyMMF=V19ph=HMvqOfC51w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjxTw0k33XqoEUrT6iHdOWrnyMMF=V19ph=HMvqOfC51w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 09:11:57AM +0300, Amir Goldstein wrote:
> On Fri, Oct 27, 2023 at 9:01 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 10:46:06PM +0300, Amir Goldstein wrote:
> > > I would much rather turn EXPORTFS into a bool config
> > > and avoid the unneeded build test matrix.
> >
> > Yes.  Especially given that the defaul on open by handle syscalls
> > require it anyway.
> 
> Note that those syscalls depend on CONFIG_FHANDLE and the latter
> selects EXPORTFS.

Yes, this means that for all somewhat sane configfs exportfs if always
built in anyway.  And for the ones where it isn't because people
are concerned about micro-optimizing kernel size, nfsd is unlikely
to be built in either.

> The bigger issue is that so many of the filesystems that use the
> generic export ops do not select EXPORTFS, so it's easier to
> leave the generic helper in libfs.c as Arnd suggested.

Agreed.

