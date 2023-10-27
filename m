Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913767DA1BE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 22:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjJ0U2e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 16:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0U2e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 16:28:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEB1AA;
        Fri, 27 Oct 2023 13:28:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12176C433C7;
        Fri, 27 Oct 2023 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698438511;
        bh=CHg2FCXQg1uLVbCPEvYlaMw0GzG2eevfyBDReT+5JuE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=quJuJNRdjuob8boA983k4FOnreDfGAbL6gqlB1tiJNds7qyczUFBsCwBzJKEe9ty3
         kE4cjREP4EG+ScDAKsfQlX8hP/1ind1IJXMbrxbYX7vpKD5Zznj3wV2CPhW/sAyDzH
         C9oFIFM48XI/Nk0CESVq1CxkevR3S7rDQO5C1wcouqcSxzktnxjsQCzjpbsXzXX8Wg
         iDZkyOTlVpDHennrlOuWkmnAFnPXw611oYu3VtOuD/9hjBWiuwPQZT9dBOfgi/Bxul
         QQ9QG3eJcq/KKmnHzef3g2FBibBnoovV6LqDusemjxOnEVfSsL0wH/4JL01Xz16kuR
         5qW3apIL89EJg==
Message-ID: <702fe81a44d3526cd2ec87bf8cd79741ac0d0782.camel@kernel.org>
Subject: Re: [PATCH] nfsd_copy_write_verifier: use read_seqbegin() rather
 than read_seqbegin_or_lock()
From:   Jeff Layton <jlayton@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Oct 2023 16:28:29 -0400
In-Reply-To: <20231026145018.GA19598@redhat.com>
References: <20231025163006.GA8279@redhat.com>
         <20231026145018.GA19598@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-10-26 at 16:50 +0200, Oleg Nesterov wrote:
> The usage of read_seqbegin_or_lock() in nfsd_copy_write_verifier()
> is wrong. "seq" is always even and thus "or_lock" has no effect,
> this code can never take ->writeverf_lock for writing.
>=20
> I guess this is fine, nfsd_copy_write_verifier() just copies 8 bytes
> and nfsd_reset_write_verifier() is supposed to be very rare operation
> so we do not need the adaptive locking in this case.
>=20
> Yet the code looks wrong and sub-optimal, it can use read_seqbegin()
> without changing the behaviour.
>=20
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/nfsd/nfssvc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..094b765c5397 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
>   */
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
>  {
> -	int seq =3D 0;
> +	unsigned seq;
> =20
>  	do {
> -		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> +		seq =3D read_seqbegin(&nn->writeverf_lock);
>  		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> -	} while (need_seqretry(&nn->writeverf_lock, seq));
> -	done_seqretry(&nn->writeverf_lock, seq);
> +	} while (read_seqretry(&nn->writeverf_lock, seq));
>  }
> =20
>  static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
