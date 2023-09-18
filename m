Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254287A4E41
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjIRQJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIRQJN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:09:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242C49F3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:07:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C61C43215;
        Mon, 18 Sep 2023 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695051730;
        bh=Lg5m/KvhE4UCtOEJ6Q1ndDQoWhkmH97hPVsIEtvEHU0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Iq07Xxq2NIbUcrz2+qdmIiESFJL4SOHRc+DDmOn7MftZ4fIQ8wjuN30a/Gp9+UQS2
         /7LVyaKwGuutNjKbynlskaz6qlhFqakFgCMISKmKIin52FoQX1vZyaLYzA1w1FPVX5
         U3kRn7ktN0CkOlQTFMMqLQAQa/lTRIXks9D6TmqIfTeNTpcMJ9yQ0PbgUytbZLbaZf
         zRWRmri4kwgQc9b/8iYIAIQwaT1Qtk8o65mVni0rg/FHK1uLoF3TGhEBbUOLl2z3EA
         Oss4EJyXTAJfVmHUsY+/zTY69zpUuKi+5KzfhSfLiFviGgThxcRF8DgysGkL0gTkqR
         rGx7cklAA7VFA==
Message-ID: <f2d0018145fda00a25835a7ba7347515d8e06015.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 18 Sep 2023 11:42:08 -0400
In-Reply-To: <1694648301-26746-1-git-send-email-dai.ngo@oracle.com>
References: <1694648301-26746-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-09-13 at 16:38 -0700, Dai Ngo wrote:
> Currently GETATTR conflict with a write delegation is handled by
> recalling the delegation before replying to the GETATTR.
>=20
> This patch series add supports for CB_GETATTR callback to get the latest
> change_info and size information of the file from the client that holds
> the delegation to reply to the GETATTR from the second client.
>=20
> v2:
>   . fix kernel test robot report of missing function parameter descriptio=
n
>     of nfsd4_deleg_getattr_conflict()
>=20

This all looks good to me. Nice work, Dai!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
