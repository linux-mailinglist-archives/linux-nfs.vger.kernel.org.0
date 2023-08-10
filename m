Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57F5778034
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHJSZK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 14:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjHJSZJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 14:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088932690
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 11:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9302B665C6
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 18:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A6CC433C7;
        Thu, 10 Aug 2023 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691691907;
        bh=FF+vZQWzbhs6UInpEkjINNg151Ulg6gpIQpWY3/smkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQMjM32HmmIKu1DwVeAgKyUKi6VV1VbDf5ttBmTf6XSLDGdvF+iArLjBMp5u0Iodc
         jJ27rtntySBvgsa0LTWKRaX//JR5ISplYDKz/MwIcUp0F5nALPqbWe+lL/39aoSWoT
         pAbWIWy56cQp5xaiYaGEvRnflOMQZy1do95rxBaFGkE++6AV8CzRob6k6Pk2QcCwtf
         tRVPCMu7t/QEJwX8JZY2Uv5PoW1S0zGB35ey/j5+z69+w8nB4n3gMy7PlkZCU55chS
         +AchpjKwq9JG+UKwagfoGrBn3rvRAv1reocRPU4y3eIgTa0GHOqNOtNZq2Gs7iJMIL
         IZyUZOQ/9d0Lg==
Date:   Thu, 10 Aug 2023 20:24:54 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v6 3/3] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZNUrdju18XO4hYMe@lore-rh-laptop>
References: <cover.1691656474.git.lorenzo@kernel.org>
 <177cfd4fc640d9b406101761be24da07990ca81e.1691656474.git.lorenzo@kernel.org>
 <ZNT7wdG8SYfDRkDg@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1rgV5QfxaAXrIvUy"
Content-Disposition: inline
In-Reply-To: <ZNT7wdG8SYfDRkDg@tissot.1015granger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--1rgV5QfxaAXrIvUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
> > +				struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> > +				int j;
> > +
> > +				opcnt =3D args->opcnt;
> > +				for (j =3D 0; j < opcnt; j++) {
> > +					struct nfsd4_op *op =3D &args->ops[j];
> > +
> > +					rqstp_info.opnum[j] =3D op->opnum;
> > +				}
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +			/*
> > +			 * Acquire rq_status_counter before reporting the rqst
> > +			 * fields to the user.
> > +			 */
> > +			if (smp_load_acquire(&rqstp->rq_status_counter) !=3D status_counter)
> > +				continue;
> > +
> > +			seq_printf(m,
> > +				   "%04u %04ld NFSv%d %s %016lld",
> > +				   be32_to_cpu(rqstp_info.rq_xid),
>=20
> It's proper to display XIDs as 8-hexit hexadecimal values, as you
> did before. "0x%08x" is the correct format, as that matches the
> XID display format used by Wireshark and our tracepoints.

ops, I misunderstood your previous comments. I will address them in v7 if t=
here
are no other comments.

Regards,
Lorenzo

>=20
>=20
> > +				   rqstp_info.rq_flags,
>=20
> I didn't mean for you to change the flags format to decimal. I was
> trying to point out that the content of this field will need to be
> displayed symbolically if we care about an easy user experience.
>=20
> Let's stick with hex here. A clever user can read the bits directly
> from that. All others should have a tool that parses this field and
> prints the list of bits in it symbolically.
>=20
>=20
> > +				   rqstp_info.rq_vers,
> > +				   rqstp_info.pc_name,
> > +				   ktime_to_us(rqstp_info.rq_stime));
> > +			seq_printf(m, " %s",
> > +				   __svc_print_addr(&rqstp_info.saddr, buf,
> > +						    sizeof(buf), false));
> > +			seq_printf(m, " %s",
> > +				   __svc_print_addr(&rqstp_info.daddr, buf,
> > +						    sizeof(buf), false));
> > +			if (opcnt) {
> > +				int j;
> > +
> > +				seq_puts(m, " ");
> > +				for (j =3D 0; j < opcnt; j++)
> > +					seq_printf(m, "%s%s",
> > +						   nfsd4_op_name(rqstp_info.opnum[j]),
> > +						   j =3D=3D opcnt - 1 ? "" : ":");
> > +			} else {
> > +				seq_puts(m, " -");
> > +			}
>=20
> This looks correct to me.
>=20
> I'm leaning towards moving this to a netlink API that can be
> extended over time to handle other stats and also act as an NFSD
> control plane, similar to other network subsystems.
>=20
> Any comments, complaints or rotten fruit from anyone?
>=20
>=20
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
> > + * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
> > + * @inode: entry inode pointer.
> > + * @file: entry file pointer.
> > + *
> > + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs=
 handler.
> > + * nfsd_rpc_status dumps pending RPC requests info queued into nfs ser=
ver.
> > + */
> > +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> > +{
> > +	int ret =3D nfsd_stats_open(inode);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> > +}
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 7838b37bcfa8..b49c0470b4fe 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -251,6 +251,7 @@ struct svc_rqst {
> >  						 * net namespace
> >  						 */
> >  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> > +	unsigned int		rq_status_counter; /* RPC processing counter */
> >  };
> > =20
> >  /* bits for rq_flags */
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index af692bff44ab..83bee19df104 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1656,7 +1656,7 @@ const char *svc_proc_name(const struct svc_rqst *=
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
> > --=20
> > 2.41.0
> >=20
>=20
> --=20
> Chuck Lever

--1rgV5QfxaAXrIvUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZNUrcgAKCRA6cBh0uS2t
rBQEAQCoX65i3ycyknJqzmh9hlUJmMgOyG/d2pnZazl9rTlaHQD/VJMiaDUkfLE8
jBSGmQwrohIesVNgN9fvIWVik5WmOgg=
=E939
-----END PGP SIGNATURE-----

--1rgV5QfxaAXrIvUy--
