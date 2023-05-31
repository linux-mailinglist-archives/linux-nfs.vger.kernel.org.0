Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6957187F1
	for <lists+linux-nfs@lfdr.de>; Wed, 31 May 2023 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEaRDA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 May 2023 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEaRCz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 May 2023 13:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC911D
        for <linux-nfs@vger.kernel.org>; Wed, 31 May 2023 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685552531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nA468CPms0dwjrbNccXgZQd/+AP0rCkmXR+Xx2SRtqE=;
        b=Rs6ZElUCAiplIY/+nVrdAryriEfInnmdaqsbpbijAK/kEOD62zJQoTRC8YGMWVXgdRhQd9
        O1nYjjlTRmw08A/yOgsammgRD9b4fp+u5ku9+kuw6VpMeoyDYVift1hgbIVnAvGwzsZwFr
        tLgIj5GSWQEsPXHYOpFrkg7N13JC4MU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-cycqWSbcNNOBUdVOr9AGhg-1; Wed, 31 May 2023 13:02:07 -0400
X-MC-Unique: cycqWSbcNNOBUdVOr9AGhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A306185A78B;
        Wed, 31 May 2023 17:02:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0C8C154D7;
        Wed, 31 May 2023 17:02:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Chuck Lever <chuck.lever@oracle.com>
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: How to get my krb5 crypto lib upstream?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <723505.1685552525.1@warthog.procyon.org.uk>
Date:   Wed, 31 May 2023 18:02:05 +0100
Message-ID: <723506.1685552525@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Herbert, Chuck,

I'm wondering how to make progress on getting my krb5 crypto lib upstream.

Can I push it as it stands and then we try and build it into the crypto API
for it later?  That would allow me to push my rxgk implementation for AF_RXRPC
and at least allow userspace to use that.

As far as building a crypto API around it goes, we need four interfaces:

 (1) Key generation.  We may need to generate a {cipher,hash} key pair {Ke,Ki}
     or just a hash key Kc.  We might conceivably want both.

     At the moment, I return a prepared cipher or a prepared hash.  I don't
     deal with the key pairing here as it makes testing a bit more awkward.

	int crypto_krb5_get_Kc(const struct krb5_enctype *krb5,
			       const struct krb5_buffer *TK,
			       u32 usage,
			       struct krb5_buffer *key,
			       struct crypto_shash **_shash,
			       gfp_t gfp);
	int crypto_krb5_get_Ke(const struct krb5_enctype *krb5,
			       const struct krb5_buffer *TK,
			       u32 usage,
			       struct krb5_buffer *key,
			       struct crypto_sync_skcipher **_ci,
			       gfp_t gfp);
	int crypto_krb5_get_Ki(const struct krb5_enctype *krb5,
			       const struct krb5_buffer *TK,
			       u32 usage,
			       struct krb5_buffer *key,
			       struct crypto_shash **_shash,
			       gfp_t gfp);

 (2) PRF+ generation.  This takes some a key and a metadata blob and generates
     a new blob that then gets used as a key.

	int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
				     const struct krb5_buffer *K,
				     unsigned int L,
				     const struct krb5_buffer *S,
				     struct krb5_buffer *result,
				     gfp_t gfp);

 (3) Encrypt and Decrypt.

     Encrypt has to be parameterised to take a specific confounder for testing
     and generate a random one for normal operation.  The IV is fixed all
     zeroes in the cases I've implemented.  When testing, decrypt should
     perhaps be passed the confounder to check it.

     When encrypting, the output buffer will be larger than the input buffer
     (or, at least, room must be set aside) so that a confounder, padding and
     a checksum can be inserted.

     When decrypting, we either want to provide a separate output buffer so
     that the confounder and checksum can be stripped off, or we need to be
     able to find out where the decrypted payload plus the padding will be (we
     can't work out how much padding there is - that's left to the caller).

     At the moment, I pass a single buffer descriptor, providing encrypt with
     extra space front and back and providing decrypt with somewhere to save
     offset and length:

	ssize_t crypto_krb5_encrypt(const struct krb5_enctype *krb5,
				    struct krb5_enc_keys *keys,
				    struct scatterlist *sg, unsigned int nr_sg,
				    size_t sg_len,
				    size_t data_offset, size_t data_len,
				    bool preconfounded);
	int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
				struct krb5_enc_keys *keys,
				struct scatterlist *sg, unsigned int nr_sg,
				size_t *_offset, size_t *_len,
				int *_error_code);

     I also allow a krb5/gssapi error code to be returned so that it can be
     used in the generation of abort messages.  This needs sorting out
     better.  It may be that only one code is actually relevant to this and
     that the caller generates all the rest as it checks the metadata.

     The AEAD interface might suffice as it stands if we pass in the keys
     already generated and passed in as a single key blob.  We don't want an
     IV generator as the protocol defines the IV to use.

 (4) GetMIC and VerifyMIC.

     Both of these need parameterising with extra metadata that will get
     inserted into the hash before the data is hashed.  GetMIC will insert the
     checksum into the buffer and VerifyMIC will check it and strip it off.

     I'm not sure that the hash API is suitable for this.  AEAD might suit for
     GetMIC at least, but using AEAD for VerifyMIC would lead to an extraneous
     copy I'd prefer to avoid.


	ssize_t crypto_krb5_get_mic(const struct krb5_enctype *krb5,
				    struct crypto_shash *shash,
				    const struct krb5_buffer *metadata,
				    struct scatterlist *sg, unsigned int nr_sg,
				    size_t sg_len,
				    size_t data_offset, size_t data_len);
	int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
				   struct crypto_shash *shash,
				   const struct krb5_buffer *metadata,
				   struct scatterlist *sg, unsigned int nr_sg,
				   size_t *_offset, size_t *_len,
				   int *_error_code);

There's a lot to be said in using an asynchronous overrideable interface for
encrypt and decrypt.  The problem is that we want to do simultaneous hash and
crypt if we can.  I think the Intel AES/SHA instructions permit this to be
done and there is sufficient register space to do it - and I *think* that it
may be possible to offload this to the Intel QAT or the Intel IAA on the
latest 4th Gen Xeons - and maybe NICs that can handle NFS/SMB offload.

I think we'll perhaps need a "krb5 encoding type" API that can provide key
derivation, PRF+ and information - something along the following lines:

	struct krb5_enctype {
		int		etype;		// Encryption (key) type
		int		ctype;		// Checksum type
		const char	*name;		// "Friendly" name
		const char	*encrypt_name;	// Crypto encrypt name
		const char	*cksum_name;	// Crypto checksum name
		const char	*hash_name;	// Crypto hash name
		u16		block_len;	// Length of encryption block
		u16		conf_len;	// Length of confounder
		u16		cksum_len;	// Length of checksum
		u16		key_bytes;	// Length of raw key
		u16		key_len;	// Length of final key
		u16		hash_len;	// Length of hash
		u16		prf_len;	// Length of PRF() result
		u16		Kc_len;		// Length of Kc
		u16		Ke_len;		// Length of Ke
		u16		Ki_len;		// Length of Ki
		bool		keyed_cksum;	// T if a keyed cksum
		bool		pad;		// T if should pad
	};

We need to be able to look the encoding up by ID, not by name.

David

