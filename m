Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2D6A0AD4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 14:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjBWNns (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 08:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjBWNns (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 08:43:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA514D63B
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 05:43:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p8so10847879wrt.12
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 05:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NEVkhq382iJoTGqp5+ypgi30+HVgIdIqYCgE6Pid48=;
        b=LzvjxxxomV9iU0jiWSidtPrJ16UKG8b2lCw02ga7PQyr+o4bCWG/Jvd/AwkRvUHAMt
         Y+ELdPzbAPnTyQeHdEwbXlY8dMRX+PBwmMEak93Yqdnn/NwuIpKOXpGIlzM3q02VYPeV
         855DTPc8B8oEmnl9VJ2t0213rFLwSWLTZV/yMqwyF3kV9LtbowWsjX1+L0wafrQHtE2L
         DXrb0ft1JzUGRGPQuyXdM+R+APLyVPZbaWJu6vv9ZVBGeQUznrQsJjSPpOfMjVcDTcp9
         1GsthsEmnFiTkQwPWyNFSGZNRTMIsajFLp/L6oDDf6BrJqs5JeAXP33nsMPXEBSCyNFw
         PT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NEVkhq382iJoTGqp5+ypgi30+HVgIdIqYCgE6Pid48=;
        b=cyHfCO5csVJlodjaQjcPtUF/OPXcwwTNITrXhf+q2pCI0IxWuj9xnm5KPdlhSpf/NK
         F05yxhPuLwiEiEt78Bgoh0wWgca4gjDcs4rfth2A3jFgG/RNEQcZB6v+Cfbq016If4Y5
         r2bRYcfnz3kQo7/MI8cWv0qJ2Enceyv/nRTK64nByBEnL6y4I7jx3BZrRmpwOsm1kLq8
         glnxAPvM6NB9GO4YYQGSiT0H23lb25CqKDDB/81wJ2F8Gol05kQLGC60yDIjxHEDyV1z
         MRAQBBzegz1+FrN5FZnT3vCn4Rn+Uf57Dih0LbhyIUSjH63RFueeijGz2drLSqnKWACo
         UX4g==
X-Gm-Message-State: AO0yUKXivU3YW+0HtZ9lxCCsdKRUgx6TufXIy2d9BDN+9MMC/Uh+zY45
        DKBJCHwSu16FJCCBz/qegQzYZ27UITlARQ==
X-Google-Smtp-Source: AK7set8PiBXOD47/5nEre13ZtoX/h8v7vGWAYeq750TAi/6qhGnNZXh+LrWol/TpMpudi/3y6QXu3g==
X-Received: by 2002:a5d:4e09:0:b0:2c5:789d:804f with SMTP id p9-20020a5d4e09000000b002c5789d804fmr10794317wrt.55.1677159825512;
        Thu, 23 Feb 2023 05:43:45 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d458b000000b002c707b336c9sm6097180wrq.36.2023.02.23.05.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:43:44 -0800 (PST)
Date:   Thu, 23 Feb 2023 16:43:39 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     trondmy@kernel.org, Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 18/18] NFS: Remove unnecessary check in
 nfs_read_folio()
Message-ID: <Y/dti5+1vp55tMZX@kadam>
References: <20230119213351.443388-11-trondmy@kernel.org>
 <20230119213351.443388-12-trondmy@kernel.org>
 <20230119213351.443388-13-trondmy@kernel.org>
 <20230119213351.443388-14-trondmy@kernel.org>
 <20230119213351.443388-15-trondmy@kernel.org>
 <20230119213351.443388-16-trondmy@kernel.org>
 <20230119213351.443388-17-trondmy@kernel.org>
 <20230119213351.443388-18-trondmy@kernel.org>
 <20230119213351.443388-19-trondmy@kernel.org>
 <Y/dorq8Elh4Mxg2g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/dorq8Elh4Mxg2g@casper.infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 23, 2023 at 01:22:54PM +0000, Matthew Wilcox wrote:
> But I'm suspicious of static match tools claiming it can't ever happen,
> and I'd like more details please.  I can't find the original report.

I would never write a warning like that...  However at the time when
I reported the bug then Smatch did say that all the callers passed a
non-NULL file pointer.  I've reviewed my logs and that was true when I
said it but it's not true now.  :(  Now Smatch says there are three
callers and nfs_write_begin() passes a valid pointer, read_pages()
passes either a valid pointer or a NULL and filemap_read_folio() passes
an unknown pointer.

https://lore.kernel.org/all/Y77+n9MyHgx%2FalA4@kadam/

The issue here is that the pointer was already derefernced on the lines
before the check for NULL.

	struct inode *inode = file_inode(file);

So either the dereference or the check was wrong.

regards,
dan carpenter

