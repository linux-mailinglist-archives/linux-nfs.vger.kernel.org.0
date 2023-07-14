Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6275401A
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjGNRBs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjGNRBj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 13:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CDF35A9
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 10:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE3761D52
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 17:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F58C433C7;
        Fri, 14 Jul 2023 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689354096;
        bh=L7RDCdcofj+E7DDX4ZqYN22f7srt1Pi6lLmOQr19V9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq1b8zGHyTfrjA+efv7NMApN+x3jppPhUNNjUIHjaiuyWXo4LeaRUW6iG8G0HSr8U
         zfUpmiujB8Yy0Td4Jl/mo4P/p53qxpo3Av0mSZgger24yn7qC9oCCb6Af8htsM5cLa
         RxXruY7tKrDg2nKlAAEjd3UA0HVdyfpGNzF26ACtpumeVYJO/KCFwYnWlABffp6eYu
         dyrw9avN9thyiM/3L1zUFgHVIDbKrB3Y/S5O6WW2pRnW0ZYAtw9HQcmoZeNpdkGQa4
         eIiVrrIm3GIzc8/RyLbi9JfwRw+TcycVui+Nio6uSY/zbzcXPQv+/M70K1QBFfqBLs
         AsayuWaw8L/jA==
Date:   Fri, 14 Jul 2023 19:01:33 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com
Subject: Re: [PATCH v2] NFSD: add rpc_status entry in nfsd debug filesystem
Message-ID: <ZLF/bedAa57iys+q@lore-desk>
References: <c86b81f1d63f4105a2772c83746a3e5a88300bbd.1689198106.git.lorenzo@kernel.org>
 <d0b5e760aebaff9a587a83c7d69f71a5d71f01e6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/WJP/jgjqlsjBkYG"
Content-Disposition: inline
In-Reply-To: <d0b5e760aebaff9a587a83c7d69f71a5d71f01e6.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--/WJP/jgjqlsjBkYG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > +			if (rqstp->rq_addr.ss_family =3D=3D AF_INET)
> > +				seq_printf(m, " %pI4 %pI4 ",
> > +					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> > +					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> > +			else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6)
> > +				seq_printf(m, " %pI6 %pI6 ",
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> > +			else
> > +				seq_printf(m, " unknown:%hu",
>=20
> I think you'll need to add a second "unknown:%hu" here to keep the
> fields aligned. In the ipv4/6 case there are 2 addresses, so you need 2
> addresses here as well.

ack, I will fix it.

>=20
> > +					   rqstp->rq_addr.ss_family);
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
> > +				struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> > +				struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> > +
> > +				while (resp->opcnt < args->opcnt) {
> > +					struct nfsd4_op *op =3D &args->ops[resp->opcnt++];
> > +
> > +					seq_printf(m, " %s", nfsd4_op_name(op->opnum));
>=20
> Given that this is going to be a variable-length field, we should have a
> different delimiter between the different operations here. Maybe
> something like a ':' or '|' character? That way the script could parse
> the different operations, but we'd still be able to add new fields to
> the end of the line later if we decide it's worthwhile.

ack, I will fix it.

Regards,
Lorenzo

> =20
> > +				}
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +			seq_puts(m, "\n");
> > +		}
> > +	}
> > +
> > +	rcu_read_unlock();
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_rpc_status_open - Atomically copy a write verifier
> > + * @inode: entry inode pointer.
> > + * @file: entry file pointer.
> > + *
> > + * This routine dumps pending RPC requests info queued into nfs server.
> > + */
> > +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_=
id);
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	if (!nn->nfsd_serv) {
> > +		mutex_unlock(&nfsd_mutex);
> > +		return -ENODEV;
> > +	}
> > +
> > +	svc_get(nn->nfsd_serv);
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> > +}
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 587811a002c9..44eac83b35a1 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *=
rqstp)
> >  		return rqstp->rq_procinfo->pc_name;
> >  	return "unknown";
> >  }
> > -
> > +EXPORT_SYMBOL_GPL(svc_proc_name);
> > =20
> >  /**
> >   * svc_encode_result_payload - mark a range of bytes as a result paylo=
ad
>=20
> Other than the nits above, this is looking good!
> --=20
> Jeff Layton <jlayton@kernel.org>

--/WJP/jgjqlsjBkYG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLF/bAAKCRA6cBh0uS2t
rK4EAQDJjYEYcX3d5yhOqnVhikHM2f0/O5Ck/OxWr1XWhvU9QAEAxN9j6sglQh/H
YW6Xbug308lIBwDTSb0sTPjrUoKmdwU=
=ypNw
-----END PGP SIGNATURE-----

--/WJP/jgjqlsjBkYG--
