Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384D275A01F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 22:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGSUqt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 16:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSUqs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 16:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F91BF6
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689799562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wn04FBWAYUoq+laJF44ibKdig5vwWfN1vjPkzaogQnc=;
        b=hvZH1dtzzSGRkpnETa6VdGvfbhZiTb/2BMmVh6Ey9qdxhcl422kDNu7MLXHGJtHtyqlNoQ
        vNWyrzp2SCVQeZIcc+e4jvngR1U8rozXs/cRcnr2ynoDmXJxXFm/FupjdneY+RSYEyw+zG
        sobimbcpgNYownc2KmXovzdaL65dlns=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-PqmnP3YINkyzvOo74kp_hw-1; Wed, 19 Jul 2023 16:46:00 -0400
X-MC-Unique: PqmnP3YINkyzvOo74kp_hw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-316f39e3e89so523937f8f.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 13:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689799559; x=1690404359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn04FBWAYUoq+laJF44ibKdig5vwWfN1vjPkzaogQnc=;
        b=KY7MJ/9OUYRaQd5vTjJVVRAGkNoVhLtHAmQdUEZuHITYLPwd4lTrg/5MwkTBw8a9k9
         daYdAEXtd+2UBd83O7SzGaAEg/VhawAD0FjR83IXEp9uRE/HJmxPkwL9Ov+UaItrk6Hx
         gW4kloXe/KC6RrXVQT+haDLi9Cie5p7zvuEf6mZRlQ5M7XY8nXGolCa8eNo4GwXHImkG
         YPFn6GoQwG+2HA8ljh6qCE6+vTV4pdRWMbhhC0k7XppvWbHW796+O84l6lKBURBvTzcL
         oaNkD5BoEtzFnnYscutkLrYeB9HQJeUmKk5NGdv5mUiyRRvxwsqce/4zE85dzn3sT6za
         GF8g==
X-Gm-Message-State: ABy/qLbeaCMpjHxr8lmtSrCi0c0iaoVRw2yCghzI04MKAUahohCb81zr
        sLFYa1lzUVQn5p6QJTkIDJkB0VXCqa/dEVWCR528ONeFGKyrTCdg0PMnm5uwMqhULCbFXXyQjZm
        MwTZGOo4E2l54aHh9PWaO/85Tk2jO
X-Received: by 2002:a05:6000:1041:b0:314:9dc:4c4 with SMTP id c1-20020a056000104100b0031409dc04c4mr716076wrx.2.1689799559421;
        Wed, 19 Jul 2023 13:45:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLWaSRQLfa6rcm5BqxzLdPS0n+kRPkA2K8OrdtTOaPaBtxXoaW/QBpQAYtkg9zWPBVjy0bCA==
X-Received: by 2002:a05:6000:1041:b0:314:9dc:4c4 with SMTP id c1-20020a056000104100b0031409dc04c4mr716064wrx.2.1689799559086;
        Wed, 19 Jul 2023 13:45:59 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b00314172ba213sm6085575wrw.108.2023.07.19.13.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:45:58 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:45:56 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [PATCH v3] NFSD: add rpc_status entry in nfsd debug filesystem
Message-ID: <ZLhLhAyvdPh/HnSa@lore-desk>
References: <4aa3c87872031ca42d411ed60169c6daa951620b.1689610081.git.lorenzo@kernel.org>
 <168963056470.1518.10737362406173956339@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j17ekJPM9tJOKO7q"
Content-Disposition: inline
In-Reply-To: <168963056470.1518.10737362406173956339@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--j17ekJPM9tJOKO7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> The fact that RQ_BUSY is set doesn't mean that the various fields you
> are sampling are valid or stable.
>=20
> I suggest you add add a counter to the rqstp which is incremented from
> even to odd after parsing a request - including he v4 parsing needed to
> have a sable ->opcnt - and then incremented from odd to even when the
> request is complete.
> Then this code samples the counter, skips the rqst if the counter is
> even, and resamples the counter after collecting the data.  If it has
> changed, the drop the record.

Hi Neil,

thx for the review. Ack, I will look into it.

>=20
> > +
> > +			seq_printf(m,
> > +				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
> > +				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> > +				   rqstp->rq_prog, rqstp->rq_vers,
> > +				   svc_proc_name(rqstp),
> > +				   ktime_to_us(rqstp->rq_stime));
> > +
> > +			if (rqstp->rq_addr.ss_family =3D=3D AF_INET)
> > +				seq_printf(m, " %pI4 %pI4",
> > +					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> > +					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> > +			else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6)
> > +				seq_printf(m, " %pI6 %pI6",
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> > +			else
> > +				seq_printf(m, " unknown:%hu unknown:%hu",
> > +					   rqstp->rq_addr.ss_family,
> > +					   rqstp->rq_daddr.ss_family);
>=20
> The above code looks a lot like svc_print_addr().  Can we use the same
> code?  Do they need to be different.

ack, I will look into it.

Regards,
Lorenzo

>=20
> NeilBrown
>=20
>=20
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
> > +					seq_printf(m, " %s%s", nfsd4_op_name(op->opnum),
> > +						   resp->opcnt < args->opcnt ? ":" : "");
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
> > --=20
> > 2.41.0
> >=20
> >=20
>=20

--j17ekJPM9tJOKO7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLhLhAAKCRA6cBh0uS2t
rMl8AQDvMCUljGfkLlDy8kNYWRx9q5EVUw0HrCf5ocvvKW2vEAEAh8/rHv6Ihz0P
ABECO6z02j2UD6qYXqcPp/ZeKko7Lg8=
=ng4F
-----END PGP SIGNATURE-----

--j17ekJPM9tJOKO7q--

