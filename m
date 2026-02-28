Return-Path: <linux-nfs+bounces-19442-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPKPC6Eko2kC+AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19442-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 18:23:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA01C4DFA
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 18:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FFB430263F5
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7902C178D;
	Sat, 28 Feb 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlpYdH5L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A03093DF
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299421; cv=pass; b=d0oKHgYcspXCMlSOg9bF6r5XRkannuCvAbh+9Q3jlhQ0UXE48l6hznNYCVZVdjyqs8c183F3HdPcZN8X1RcVsDvuinSM5qYFOFyfnt8U+a+AHS3lj/vlLPVyOekFDOfC2Ly3ZVBaBm5WX2/Y2sNYgFbxmC0q74gE2qNDmG0nSSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299421; c=relaxed/simple;
	bh=SYL/RglKWV222F8qNl6faChb38xRGOantLcpNv7GtJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BweSUIZsxggW1VmxRGCzkwYoGtAIDxbA19/fmBIh0/xdkejCUMzF23JDt4Rtba1UvbDnY3S9+oc4DVvaIHcr5xravEbk+aW0VEC0TOn9gYJuhYIigPabUpQg0SShKXxfrkUAAPdaXIj7YFsyLelphMQFLcHeJcKHZqs1moRLn8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlpYdH5L; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a8da2faf4so2566753e0c.2
        for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 09:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772299419; cv=none;
        d=google.com; s=arc-20240605;
        b=DRlPwRXiVMSptw1kloia8UoirqiMvJsLsweTey3PsV5+359H8QTd7i/UFkf5EeDrND
         HGBMSWMqENSWaCt5qKJaajQzJjhKeAsvHex2AOuj1Lp8FRv4J+L97faxBJcvXq+jETGL
         yWz+d8O9MSZ3bhuGAhLljZ6J/Gctay0/IG3waOhOr21yhC3G7DJE66CKpWM/EPz2xJl/
         2V46AlurJzDo7Ryr/xdLLljohw1lUz1uLJTZyJDWHC2Wn7tdndwZE7ulpLcbNXfoxf2r
         dGFz3ihl1PCQo+x7MXdp/TUERIdYMWGxw4m/R4fG/De5pONzqavJRAM9CaHURUCkabWG
         x17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FRd7a/R2xosKdBV4aMY7VY/BHvwASNNHg8EMXb+3ATA=;
        fh=bAQo9XRcBT4IvfqFI02nrz/Fpy6bkwypWjfSCXbOmR8=;
        b=NPBwClsA2fDz3sD9AcacliIF5yE75LOViES+6JpWtY4IZt/u3umb2bcf2VPBlHr1sy
         O9yzwPIS44L6R4q4b9JFqHz3qIp7F7SnVhK0t6p2sUINGfB9xHajkU5+fRKGVCHJbHvD
         gZqPYWrVEbBwRVL4S/9fwA+6qegWf26rjCGj3MiwJ+dhyOsFaYlonJT3ButkFQEFq0fa
         9hLqO53ogMEpB/JvACWAewLvoHltyMEwu9UBCWIxTPjX5Q0dobN83fFPzh+zCzpVlBAH
         4pK6nnJNgLvqTYb0yIAYHKdR/Z3xMzE7j2ykJH9Id917kv0aaz8vegW+sysBBCIBPOKM
         ra0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772299419; x=1772904219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRd7a/R2xosKdBV4aMY7VY/BHvwASNNHg8EMXb+3ATA=;
        b=AlpYdH5LKpF3Xx9Hsm3RtNR+WvMdK11rGzluOxBH3qrfXRB5yP6b65jirPZ8ChKe2E
         UdRdRomrcg99X+RkxWhxsgFRxWG0ybnnE70UR3isbWx/suyKI7sz+4HmNcN/OYTIzRAO
         ep8JiFr44MH59BlORpQHCEDX+KP/du3A6KpxYL64SI4uBQlut4DuWfobT0N/QYOjmo38
         EsON6+rLn6MFLNPV2EPqMmJejniKn4MAosSz2LKEzxQXMGXKM5yZer2Slf0q0hMfaGgw
         ADBSQ68y4UzlI7b69GPdUZnQOPH9GOuX3c+P1INGUOOZFIR97U15ZINOl784fVbcYUeG
         JRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299419; x=1772904219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRd7a/R2xosKdBV4aMY7VY/BHvwASNNHg8EMXb+3ATA=;
        b=uvHEJsqj0mJ8Q44gUCVC9TsTHgnPE1c1VslpEssSR8Ausm/GoYbFVW2WYc6PYAe6P9
         aQozXOi+0ZJl48Y6P3XM8nD0TIPNYviA8saCIU7DhwNiK9WldTDu4oM4PCshfU8K9sUa
         X5VeJ4IaLkR/9SjhV/jx0N5PawaI0aaaMQE01ziKn+Uo6LqaMB10Ti45kkuI9SKKP3Oj
         Ips6DWBFSjISCVZ4tTQTo5CwbESyMkXRVxL5jvt3CH4VdEn/dc80Uk3JNF1w/QUThWOM
         /DAJwPTodLAF9iJSCHdS1cmDel3wg+qkkyl8TGcKf2Mslh8T6vs2R+fE2e6ndgjYN+wM
         VHqw==
X-Forwarded-Encrypted: i=1; AJvYcCVoZ9BofU6DlAZi2Qq0T7IJzA6jCsq7HE4l8JrQn/aYmG0/VSFqV9ORoP6pl2PJkVeWabfDeffFTcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySD/f8fFDNSDTHnhKjBztwYOMJlJMp7Du3DFPo9fXZyft9/o0d
	PQZRKw7eOAY2YA22kbvE3YIffekQn0HdvbPHTIKe3LT98RvtRcWCbdGz6ZZc5RWNjCPy89Ckt0Q
	6p07uo2HJUuiVV2X4XKH70H9gTJaJbYo=
X-Gm-Gg: ATEYQzzidlS6xqeDeMFT6Ae+eqVo+h9riQeA3bhACWU82dD+puSsNZgQBvnGniLt2HJ
	VeG3Gctp71GFv/T0FcVhEY1bEP8a+m+RcPy45pcRu7rNKg17oKKeQDdRUEDi8//Pq3VqlKQ4zdg
	z4W8RiLw/tv3Vce+Oq8fUyh3Px0ipwr+DJhlTFm9bAeSPP3l7PhDlBbG3Z9OxmXU2pkV3Tp/+fZ
	FCA1zPvw/coRKi0zj/+r0b68D8bwEL2U0O9KBFDSMQEKWg4CBcNNNNBREM41fx50o1yeb1FQncH
	9qyhpw==
X-Received: by 2002:a05:6102:5090:b0:5ef:8ad:a3bb with SMTP id
 ada2fe7eead31-5ff322f7f5amr3963126137.9.1772299418955; Sat, 28 Feb 2026
 09:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com> <20260227173814.2f928556@pumpkin>
 <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch> <20260227181532.1616f720@pumpkin>
 <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
In-Reply-To: <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sun, 1 Mar 2026 01:23:27 +0800
X-Gm-Features: AaiRm50VBcRdPfE6amFF7ZVmf4vOPPq5wbRY4fA2Mz6Mrs3dKMFEYBG--9g-jPI
Message-ID: <CAAb=EJVCA-xxqiXqy1oNgvEhv48ecDxd=OicFpFrtqrHCvhmiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using no_printk
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19442-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9EBA01C4DFA
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 10:56=E2=80=AFPM Sean Chang <seanwascoding@gmail.co=
m> wrote:
>
> On Sat, Feb 28, 2026 at 2:15=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 27 Feb 2026 18:57:33 +0100
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > >  # define ifdebug(fac)            if (0)
> > > > > -# define dfprintk(fac, fmt, ...) do {} while (0)
> > > > > -# define dfprintk_rcu(fac, fmt, ...)     do {} while (0)
> > > > > +# define dfprintk(fac, fmt, ...) no_printk(fmt, ##__VA_ARGS__)
> > > > > +# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_A=
RGS__)
> > > >
> > > > You can omit fmt, then you don't need the ##
> > > > #define dfprintk(fac, ...)  no_printk(__VA_ARGS__)
> > >
> > > /*
> > >  * Dummy printk for disabled debugging statements to use whilst maint=
aining
> > >  * gcc's format checking.
> > >  */
> > > #define no_printk(fmt, ...)                           \
> > > ({                                                    \
> > >       if (0)                                          \
> > >               _printk(fmt, ##__VA_ARGS__);            \
> > >       0;                                              \
> > > })
> > >
> > > Without fmt, gcc cannot do format checking. Or worse, it takes the
> > > first member of __VA_ARGS__ as the format, and gives spurious errors?
> >
> > By the time the compiler looks at it the pre-processor has expanded
> > __VA_ARGS__.
> > So it doesn't matter that the format string is in the __VA_ARGS__
> > list rather than preceding it.
> >
>
> Hi David,
> Thanks for the explanation. I agree that since __VA_ARGS__ will
> always contain the format string in this context, the ## and explicit
> fmt are indeed redundant. Since no_printk itself already handles
> the ##__VA_ARGS__ logic internally, there's no need to duplicate
> it in the dfprintk definition.
>
> I'll switch to the simpler in v5:
> -# define dfprintk(fac, fmt, ...)            no_printk(fmt, ##__VA_ARGS__=
)
> -# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_ARGS__)
> +#define dfprintk(fac, ...)                   no_printk(__VA_ARGS__)
> +# define dfprintk_rcu(fac, ...)           no_printk(__VA_ARGS__)
>

HI all,
I've also identified the cause of the build error in fs/nfsd/nfsfh.c
reported by syzbot [1]. The "use of undeclared identifier 'buf'" occurs
because buf is only declared within the RPC_IFDEBUG macro,
which is removed when CONFIG_SUNRPC_DEBUG is disabled.
To fix this, I will follow the pattern used in net/sunrpc/xprtrdma/
svc_rdma_transport.c by wrapping the dprintk call that references
buf within an #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) block.

static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
{
....
RPC_IFDEBUG(struct sockaddr *sap);
...
#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
sap =3D (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
dprintk(" local address : %pIS:%u\n", sap, rpc_get_port(sap));
sap =3D (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
dprintk(" remote address : %pIS:%u\n", sap, rpc_get_port(sap));
dprintk(" max_sge : %d\n", newxprt->sc_max_send_sges);
dprintk(" sq_depth : %d\n", newxprt->sc_sq_depth);
dprintk(" rdma_rw_ctxs : %d\n", ctxts);
dprintk(" max_requests : %d\n", newxprt->sc_max_requests);
dprintk(" ord : %d\n", conn_param.initiator_depth);
#endif
...
}

The refactor in fs/nfsd/nfsfh.c will look like this:

static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
struct svc_cred *cred,
struct svc_export *exp)
{
    /* Check if the request originated from a secure port. */
    if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
       RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
+#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
       dprintk("nfsd: request from insecure port %s!\n",
       svc_print_addr(rqstp, buf, sizeof(buf)));
+#endif
       return nfserr_perm;
    }

    /* Set user creds for this exportpoint */
    return nfserrno(nfsd_setuser(cred, exp));
}

This fix, along with the macro simplification suggested by David, will
be included in v5.

[1] https://lore.kernel.org/all/69a2e269.050a0220.3a55be.003e.GAE@google.co=
m/

Best regards,
Sean

