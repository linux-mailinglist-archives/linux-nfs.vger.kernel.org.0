Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905C979BCDA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbjIKV6f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbjIKRVD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 13:21:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A51A5
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 10:20:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161CDC433C8;
        Mon, 11 Sep 2023 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694452858;
        bh=X4bjx4WcSwqD8tvxg/8TGlrCU9XsGv/Cxoi4cyfXb4w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JE7K/34dQLAWJQUXeglzWOEUx52VKhMv2IDeuHk1RMsM68pqJlcplE8BnuLHHDM7P
         eAgGAdwdg98Xj7PloViMG5tSHYM6JT8VYwpL7bHwk4jMj4cl2KnfuXHOKkBDk6StsV
         itrScVgKiJrxC0pJs+eJJVhl7cwiZ4JhHb2AgUIxW8ftb+c69jorJnYGCpjt9zaT5p
         6ayAn9xZrb2/9l5CTrvczWquZRHpNH8J7IaICPt1zJZdF/zKMmgHE+Uy/F0KTSQi05
         aCQ7c12uOUzMCuB8OkTcBRcW6CDWUX8Cr+RXGBL5cWarIlxNPk03AiFROlvqG0zEy0
         RynbmzHDFe3ww==
Message-ID: <a90d95fc491e8c1037b6dd7670fbe5656ee75a97.camel@kernel.org>
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de,
        netdev@vger.kernel.org
Date:   Mon, 11 Sep 2023 13:20:56 -0400
In-Reply-To: <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
         <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
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

On Mon, 2023-09-11 at 14:49 +0200, Lorenzo Bianconi wrote:
> Introduce nfsd_server.yaml specs to generate uAPI and netlink
> code for nfsd server.
> Add rpc-status specs to define message reported by the nfsd server
> dumping the pending RPC requests.
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd_server.yaml | 97 ++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
>=20
> diff --git a/Documentation/netlink/specs/nfsd_server.yaml b/Documentation=
/netlink/specs/nfsd_server.yaml
> new file mode 100644
> index 000000000000..e681b493847b
> --- /dev/null
> +++ b/Documentation/netlink/specs/nfsd_server.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-C=
lause)
> +
> +name: nfsd_server
> +
> +doc:
> +  nfsd server configuration over generic netlink.
> +
> +attribute-sets:
> +  -
> +    name: rpc-status-comp-op-attr
> +    enum-name: nfsd-rpc-status-comp-attr
> +    name-prefix: nfsd-attr-rpc-status-comp-
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: op
> +        type: u32
> +  -
> +    name: rpc-status-attr
> +    enum-name: nfsd-rpc-status-attr
> +    name-prefix: nfsd-attr-rpc-status-
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: xid
> +        type: u32
> +        byte-order: big-endian
> +      -
> +        name: flags
> +        type: u32
> +      -
> +        name: prog
> +        type: u32
> +      -
> +        name: version
> +        type: u8
> +      -
> +        name: proc
> +        type: u32
> +      -
> +        name: service_time
> +        type: s64
> +      -
> +        name: pad
> +        type: pad
> +      -
> +        name: saddr4
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: daddr4
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: saddr6
> +        type: binary
> +        display-hint: ipv6
> +      -
> +        name: daddr6
> +        type: binary
> +        display-hint: ipv6
> +      -
> +        name: sport
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: dport
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: compond-op
> +        type: array-nest
> +        nested-attributes: rpc-status-comp-op-attr

Is there a way to do unions in netlink? We're sending down the list of
COMPOUND proc operations here for NFSv4, but it might be interesting to
send down other info for other program/version/procedures in the
future.

> +
> +operations:
> +  enum-name: nfsd-commands
> +  name-prefix: nfsd-cmd-
> +  list:
> +    -
> +      name: unspec
> +      doc: unused
> +      value: 0
> +    -
> +      name: rpc-status-get
> +      doc: dump pending nfsd rpc
> +      attribute-set: rpc-status-attr
> +      dump:
> +        pre: nfsd-server-nl-rpc-status-get-start
> +        post: nfsd-server-nl-rpc-status-get-done

Looks like a good first stab though.

Acked-by: Jeff Layton <jlayton@kernel.org>
