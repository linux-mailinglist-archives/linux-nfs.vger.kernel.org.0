Return-Path: <linux-nfs+bounces-17991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A8D32C29
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 15:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1D433087B46
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423231C576;
	Fri, 16 Jan 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbTxD2TY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F9221DAD
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574182; cv=none; b=lfIHAbWcQXFtNZbUjKeE+0BxY/X/8cwZwNZwYScckOwn5hdAo/9JsevcNfYKfh0L6Iv8idnpuifSj4a6oD1DORPUscKZwH0IFnw03Qp1Mu+AwJE57J2ne/2Ar4RuwJffwhBrSs4qdR+59jNfVi91xUEL2hezUoPKsMHCYVKuqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574182; c=relaxed/simple;
	bh=4g8otZ0FDCMijqRxs7A1NVvsDJNX5tQ14KHzGqIxm6o=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RE/bktMtcGdEOcFB6JMKa3nMh1PgMZK/ntv1zIQ+zDnAKn6lcv0OWqJrUrD7tPF1zLUH3T9nAyTBZBqdxWCzJH3pcKzKQlt3LEk5zCIZdEp2H7CZHW0fyxmx7p1xwKy7B7W5Bqdbr+mQg7IDFCRAnDJgMDJgTu6zRK+EHWy8JlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbTxD2TY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48891C19421;
	Fri, 16 Jan 2026 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574182;
	bh=4g8otZ0FDCMijqRxs7A1NVvsDJNX5tQ14KHzGqIxm6o=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=qbTxD2TY9LCkizvImZnMPySUVrq0cB5hA0XRE2Zw7+mH2hwZRKM+qBbAeW6ahHm7D
	 OA5DRakSFKe5TVXk39hlQpSb+zv3muQCNuGhIW/iO4lAHCVQUJpCQg6CKBF+e/JVtD
	 S9ZHBkj4NAoeFzQXtCcqbunVgU+4JeQj2lKvxAXCW00q0rIQFpULEXmlrnIzy3ejBJ
	 DeLm+T2qh3bQy56hl4uV/Eelho0JECuvg1Q3EzJ1f+DhN/NXlUS/bil+NfsP1+AV0E
	 1R9kREKgADFKPINn4fFHBTTy4rVfdNRK2MS7qoBs2yvOBmAzpvOyCWq9d2UOvspZl8
	 xzUd3Cm52XWOw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C68FF40069;
	Fri, 16 Jan 2026 09:36:21 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 09:36:21 -0500
X-ME-Sender: <xms:5UxqacRfsKTFIXyLHd89vBFhJO7xWkUQI-2M7QJvT9RF9Qe5gOXjxA>
    <xme:5UxqaUmyYbEyG2TRfQkO_Co3eRQu8B5NBp58zYNsIn8V-Bjh7cY_b-55tRDZzCOru
    0jRM5THxUs4NPKL7g16v6GTMM30MiZwBYHx9xhx41iXQChovgRuYf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheehjeelgeffffeihfduudevudeghfehheefhffgueeluedufeetjeduhfdukeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtvggurhhitgdrsghlrghntghhvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5Uxqae8_ohFWTBsgq7TbWFuj2RWYnZ_pWCPXA1CiUyW-uqGfjVQvZg>
    <xmx:5Uxqaco7tKHnprtnf9EnN3rIAKj6AR0luRV-xoNCphAnunWhKSjGjw>
    <xmx:5Uxqabluc_ukvxJfM6xBY3l7onnAsjgT_gA0O0_NAPqovkp9G1RU_Q>
    <xmx:5UxqaTJGxONSXXHWe0eJmRuK0TVtqJRlGtyyLq-liKUZmZQCN4P8vQ>
    <xmx:5UxqaQyCTz8TaAXMR5OVDpdyp-QZGsuq6R-cjgmkR3EOM7MxBzl-iOJP>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B073780070; Fri, 16 Jan 2026 09:36:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aa0NMh5HVlD-
Date: Fri, 16 Jan 2026 09:35:33 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Cedric Blancher" <cedric.blancher@gmail.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <1de4afee-4cd0-4738-8600-c21ffedd9f24@app.fastmail.com>
In-Reply-To: 
 <CALXu0Uf6B6GPkz5sjpjwqpyojQx7rg3v3UMnLQG4vo1hHiJeoQ@mail.gmail.com>
References: <20260114142900.3945054-1-cel@kernel.org>
 <20260114142900.3945054-16-cel@kernel.org>
 <CALXu0Uf6B6GPkz5sjpjwqpyojQx7rg3v3UMnLQG4vo1hHiJeoQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and
 FATTR4_CASE_PRESERVING
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 3:06 AM, Cedric Blancher wrote:
> Which Linux version is this patch series targeting? Linux 6.19?
>
> Ced
>
> On Wed, 14 Jan 2026 at 15:34, Chuck Lever <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> NFSD currently provides NFSv4 clients with hard-coded responses
>> indicating all exported filesystems are case-sensitive and
>> case-preserving. This is incorrect for case-insensitive filesystems
>> and ext4 directories with casefold enabled.
>>
>> Query the underlying filesystem's actual case sensitivity via
>> nfsd_get_case_info() and return accurate values to clients. This
>> supports per-directory settings for filesystems that allow mixing
>> case-sensitive and case-insensitive directories within an export.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4xdr.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 51ef97c25456..167bede81273 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2933,6 +2933,8 @@ struct nfsd4_fattr_args {
>>         u32                     rdattr_err;
>>         bool                    contextsupport;
>>         bool                    ignore_crossmnt;
>> +       bool                    case_insensitive;
>> +       bool                    case_preserving;
>>  };
>>
>>  typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
>> @@ -3131,6 +3133,18 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
>>         return nfs_ok;
>>  }
>>
>> +static __be32 nfsd4_encode_fattr4_case_insensitive(struct xdr_stream *xdr,
>> +                                       const struct nfsd4_fattr_args *args)
>> +{
>> +       return nfsd4_encode_bool(xdr, args->case_insensitive);
>> +}
>> +
>> +static __be32 nfsd4_encode_fattr4_case_preserving(struct xdr_stream *xdr,
>> +                                       const struct nfsd4_fattr_args *args)
>> +{
>> +       return nfsd4_encode_bool(xdr, args->case_preserving);
>> +}
>> +
>>  static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
>>                                              const struct nfsd4_fattr_args *args)
>>  {
>> @@ -3487,8 +3501,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
>>         [FATTR4_ACLSUPPORT]             = nfsd4_encode_fattr4_aclsupport,
>>         [FATTR4_ARCHIVE]                = nfsd4_encode_fattr4__noop,
>>         [FATTR4_CANSETTIME]             = nfsd4_encode_fattr4__true,
>> -       [FATTR4_CASE_INSENSITIVE]       = nfsd4_encode_fattr4__false,
>> -       [FATTR4_CASE_PRESERVING]        = nfsd4_encode_fattr4__true,
>> +       [FATTR4_CASE_INSENSITIVE]       = nfsd4_encode_fattr4_case_insensitive,
>> +       [FATTR4_CASE_PRESERVING]        = nfsd4_encode_fattr4_case_preserving,
>>         [FATTR4_CHOWN_RESTRICTED]       = nfsd4_encode_fattr4__true,
>>         [FATTR4_FILEHANDLE]             = nfsd4_encode_fattr4_filehandle,
>>         [FATTR4_FILEID]                 = nfsd4_encode_fattr4_fileid,
>> @@ -3674,8 +3688,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>>                 if (err)
>>                         goto out_nfserr;
>>         }
>> -       if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
>> -           !fhp) {
>> +       if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID |
>> +                           FATTR4_WORD0_CASE_INSENSITIVE |
>> +                           FATTR4_WORD0_CASE_PRESERVING)) && !fhp) {
>>                 tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
>>                 status = nfserr_jukebox;
>>                 if (!tempfh)
>> @@ -3687,6 +3702,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>>                 args.fhp = tempfh;
>>         } else
>>                 args.fhp = fhp;
>> +       if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
>> +                          FATTR4_WORD0_CASE_PRESERVING)) {
>> +               status = nfsd_get_case_info(args.fhp, &args.case_insensitive,
>> +                                           &args.case_preserving);
>> +               if (status != nfs_ok)
>> +                       goto out;
>> +       }
>>
>>         if (attrmask[0] & FATTR4_WORD0_ACL) {
>>                 err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
>> --
>> 2.52.0
>>

Because this series is a cross-subsystem change, it is almost
certainly going through Christian's VFS tree, not through the
NFSD tree. Thus none of us on this mailing list can answer the
"when" part of your question.

I can say definitely that it's not going to be v6.19, though.
That release is now closed to new features.


-- 
Chuck Lever

