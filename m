Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074226E2354
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDNMcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNMcx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 08:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E108107
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681475531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ma6AzEgjH68boZIz4seiIqCkkeg8yX+XPOYKi/FG/dU=;
        b=FWwJeuKULMtZ4U1FpprVYyFAnbpcbMmRPFIukbPJQMQgM7TFEZokEa1eHddqi3fQ/2KdFO
        clBQWO2co0uCmLx9WGdYzAjooHLc/a00u9qozyV+n/FhChHtdJF1WBELPao20xF41jQSDe
        wrUAQ3z9dlt6tjPy8qMb8Dw6ju7tmZU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-mftgtqT1Nr6Coi-CPJ3zTA-1; Fri, 14 Apr 2023 08:32:10 -0400
X-MC-Unique: mftgtqT1Nr6Coi-CPJ3zTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD88838149C1;
        Fri, 14 Apr 2023 12:32:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA1D71121320;
        Fri, 14 Apr 2023 12:32:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZDkoiqPXwIRYmeF3@gondor.apana.org.au>
References: <ZDkoiqPXwIRYmeF3@gondor.apana.org.au> <ZDkUSESImVSUX0RW@gondor.apana.org.au> <ZDi1qjVpcpr2BZfN@gondor.apana.org.au> <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com> <380323.1681314997@warthog.procyon.org.uk> <1078650.1681394138@warthog.procyon.org.uk> <1235770.1681462057@warthog.procyon.org.uk> <1239035.1681467430@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, Chuck Lever III <chuck.lever@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Did the in-kernel Camellia or CMAC crypto implementation break?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1247262.1681475528.1@warthog.procyon.org.uk>
Date:   Fri, 14 Apr 2023 13:32:08 +0100
Message-ID: <1247263.1681475528@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Could you outline how this new interface would work?

Attached is documentation for the API as I currently have it.

David
---
.. SPDX-License-Identifier: GPL-2.0

===========================
Kerberos V Cryptography API
===========================

.. Contents:

  - Overview.
    - Small Buffer.
  - Encoding Type.
  - Key Derivation.
    - PRF+ Calculation.
    - Kc, Ke And Ki Derivation.
  - Crypto Functions.
    - Encryption Mode.
    - Checksum Mode.

Overview
========

This API provides Kerberos 5-style cryptography for key derivation, encryption
and checksumming for use in network filesystems and can be used to implement
the low-level crypto that's needed for GSSAPI.

The following crypto types are supported::

	KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96
	KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96
	KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128
	KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192
	KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC
	KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC

	KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128
	KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256
	KRB5_CKSUMTYPE_CMAC_CAMELLIA128
	KRB5_CKSUMTYPE_CMAC_CAMELLIA256
	KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128
	KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256

The API can be included by::

	#include <crypto/krb5.h>

Small Buffer
------------

To pass small pieces of data about, such as keys, a buffer structure is
defined, giving a pointer to the data and the size of that data::

	struct krb5_buffer {
		unsigned int	len;
		void		*data;
	};

Encoding Type
=============

The encoding type is defined by the following structure::

	struct krb5_enctype {
		int		etype;
		int		ctype;
		const char	*name;
		u16		key_bytes;
		u16		key_len;
		u16		Kc_len;
		u16		Ke_len;
		u16		Ki_len;
		u16		prf_len;
		u16		block_len;
		u16		conf_len;
		u16		cksum_len;
		bool		pad;
		...
	};

The fields of interest to the user of the API are as follows:

  * ``etype`` and ``ctype`` indicate the protocol number for this encoding
    type for encryption and checksumming respectively.  They hold
    ``KRB5_ENCTYPE_*`` and ``KRB5_CKSUMTYPE_*`` constants.

  * ``name`` is the formal name of the encoding.

  * ``key_len`` and ``key_bytes`` are the input key length and the derived key
    length.  (I think they only differ for DES, which isn't supported here).

  * ``Kc_len``, ``Ke_len`` and ``Ki_len`` are the sizes of the derived Kc, Ke
    and Ki keys.  Kc is used for in checksum mode; Ke and Ki are used in
    encryption mode.

  * ``prf_len`` is the size of the result from the PRF+ function calculation.

  * ``block_len``, ``conf_len`` and ``cksum_len`` are the encryption block
    length, confounder length and checksum length respectively.  All three are
    used in encryption mode, but only the checksum length is used in checksum
    mode.

The encoding type is looked up by number using the following function::

	const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype);

Key Derivation
==============

Once the application has selected an encryption type, the keys that will be
used to do the actual crypto can be derived from the transport key.

PRF+ Calculation
----------------

To aid in key derivation, a function to calculate the Kerberos GSSAPI
mechanism's PRF+ is provided::

	int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
				     const struct krb5_buffer *K,
				     unsigned int L,
				     const struct krb5_buffer *S,
				     struct krb5_buffer *result,
				     gfp_t gfp);

This can be used to derive the transport key from a source key plus additional
data to limit its use.

Kc, Ke And Ki Derivation
------------------------

To do actual crypto on messages, three keys can be derived: *Kc*, used in
checksum-only mode, and *Ke* and *Ki* which are used in encryption mode for
encryption and the integrity hash.  Three functions are provided to derive
these keys from the transport key::

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

In all cases, ``krb5`` is the encoding type, ``TK`` is the transport key,
``usage`` indicates the use to which the keys will be put, ``key`` is the
prepared output buffer for the raw key and ``gfp`` are flags to control any
allocation performated.

For Kc and Ki, ``_shash`` points to where the prepared and keyed hash context
should be returned and for Ke, ``_ci`` points to where the prepared and keyed
cipher should be returned.  These will need to be passed into the crypto
functions.

For use with the encrypt/decrypt functions, a struct is provided to hold the
Ke skcipher and Ki shash::

	struct krb5_enc_keys {
		struct crypto_sync_skcipher	*Ke;
		struct crypto_shash		*Ki;
	};

and this can be cleaned up with::

	void crypto_krb5_free_enc_keys(struct krb5_enc_keys *e);

Crypto Functions
================

Once the keys have been derived, crypto can be performed on the data.  The
caller must leave gaps in the buffer for the storage of the confounder (if
needed) and the checksum when preparing a message for transmission.  An enum
and two functions are provided to aid in this::

	enum krb5_crypto_mode {
		KRB5_CHECKSUM_MODE,
		KRB5_ENCRYPT_MODE,
	};

	size_t crypto_krb5_how_much_buffer(const struct krb5_enctype *krb5,
					   enum krb5_crypto_mode mode, bool pad,
					   size_t data_size, size_t *_offset);

	size_t crypto_krb5_how_much_data(const struct krb5_enctype *krb5,
					 enum krb5_crypto_mode mode, bool pad,
					 size_t *_buffer_size, size_t *_offset);

Both functions take the encoding type, an indication the mode of crypto
(checksum-only or full encryption) and an indication if padding is going to be
required by the application.

The first function returns how big the buffer will need to be to house a given
amount of data; the second function returns how much data will fit in a buffer
of a particular size, and adjusts down the size of the required buffer
accordingly.  In both cases, the offset of the data within the buffer is also
returned.

When a message has been received, the location and size of the data can be
determined by calling::

	size_t crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
					     size_t *_offset, size_t len);

This returns the size of the data (plus any padding) and the offset of the
data.  It is up to the caller to determine how much padding there is.


Encryption Mode
---------------

A pair of functions are provided to encrypt and decrypt a message::

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

In both cases, the input and output buffers are indicated by the same
scatterlist.

For the encryption function, the output buffer may be larger than is needed
(the amount of output generated is returned) and the location and size of the
data are indicated (which must match the encoding).  If no confounder is set,
the function will insert one.

For the decryption function, the offset and length of the message in buffer
are supplied and these are shrunk to fit the data.  If a decryption failure
occurs, a kerberos 5 error code is indicated.

Checksum Mode
-------------

A pair of function are provided to generate the checksum on a message and to
verify that checksum::

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

In both cases, the input and output buffers are indicated by the same
scatterlist.  Additional metadata can be passed in which will get added to the
hash before the data.

For the get_mic function, the output buffer may be larger than is needed (the
amount of output generated is returned) and the location and size of the data
are indicated (which must match the encoding).

For the verification function, the offset and length of the message in buffer
are supplied and these are shrunk to fit the data.  If a verification failure
occurs, a kerberos 5 error code is indicated.

