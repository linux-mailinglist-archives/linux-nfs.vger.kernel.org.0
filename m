Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A697D8FDE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 09:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjJ0Hb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 03:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbjJ0HbM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 03:31:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFE1736;
        Fri, 27 Oct 2023 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OBan4m2bjYqVie4lPeBGt03STN7dr+T5kNDpo9X58JA=; b=isffc9DURlxxZa2KklA0bVwyzj
        1YYx/UE6nca7fOrnMXemDiBziZp3Z0GALLsRZDmow9ltwmMymJx5WTOM0CV4ed4lvzg13o0f0jfYK
        dvyCiLBjFFC6iVLkXFSPCgxbq0kHXvfs2QAvEkt04T4wJB0cSH4+Nwa/b7ZCSoik3o7jbHqZBiITB
        lapbVGTXU5F9kTj5ESijmSsJw0lslVC1uU5QccR/Wb9o3J5Ajn9d2TdaSMAwMCQiXE+J3N1IiWGFy
        3krGEwvZdcqOCakqVW6T+kaI8oK+jy/ZeedMe6zpohTpD3Bujvq4arEsm8whQZb/fWnlG96UmWfGG
        /T0FaphA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwHJ3-00FnWE-0W;
        Fri, 27 Oct 2023 07:30:57 +0000
Date:   Fri, 27 Oct 2023 00:30:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: create an entry for exportfs
Message-ID: <ZTtnMYJdfdIMuZnj@infradead.org>
References: <20231026205553.143556-1-amir73il@gmail.com>
 <ZTtT+8Hudc7HTSQt@infradead.org>
 <CAOQ4uxh+hWrMrP5A=fGRMK7uTxFFPKvJRNu+=Sc3ygXA1PzxvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh+hWrMrP5A=fGRMK7uTxFFPKvJRNu+=Sc3ygXA1PzxvQ@mail.gmail.com>
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

On Fri, Oct 27, 2023 at 09:35:29AM +0300, Amir Goldstein wrote:
> On Fri, Oct 27, 2023 at 9:08 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 11:55:53PM +0300, Amir Goldstein wrote:
> > > Split the exportfs entry from the nfsd entry and add myself as reviewer.
> >
> > I think exportfs is by now very much VFS code.
> >
> 
> Yes, that's the idea of making it a vfs sub-entry in MAINTAINERS.
> 
> Is that an ACK? or did you mean that something needs to change
> in the patch?

I as mostly thinking of dropping the diretory and the separate entry.
That would also go along with your patch of making it a bool.

But if you feel strongly about that we can add you as an extra reviewer
for it :)
