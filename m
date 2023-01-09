Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7DB662C60
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 18:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjAIRND (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 12:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbjAIRMa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 12:12:30 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2106.outbound.protection.outlook.com [40.107.92.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E83B4A974
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 09:11:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADYyECyEi3NQn33/1uDWXFfaiXUoYv9L+tcLEaLUiH/e1hoOhJOjv4OGAvyT4/W8pplwPI6n5g9P27ZGncEGEpxiUbEK+hr/xJ4MFMZXKBmSTJIZWOeh10TvbY+Zm0irvQsTFmJv49709sGMIEbNP2e0lZKqoSeKGDM6cDjqdBLbGTFgfQy2u3bf89PtXJ3rfkoVu5jvGCItTbSDOT1DOldd0iB9Pn7u6dyzEXscy0W7Coi86JKskOYv2tLHfW/nBHVn5rV+mk13lKXQWodEtNkMK7GPkzWMwUEodWTcc+sbcwr40eMwq+0ZRsnoh/98SJMxaWTtu3kOgg4OO+xF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiaj/8eQAB6FY/9LQZ79Uewop3CvspyLDOk5zReEdYQ=;
 b=Z/fVLOo4BewNa/GLp463jO4QD8kxAJ4FYcPoTwAw+CZ+WoRg5LmcwkGt/aADg9gWMcBPibo/7n/uQi1+2Bk0YQg5LyWWGnWI51NEgo4+HI0JIKvywLeh1V8WlxWFASG9Aa1niRY/LDOcGM1zG64KPlnpixNLQauJbO+D4RgYKGIsWTVRYkWUuQrKRkVJmsIridb+o8xiueUno+9SYXy6j0F0Uw5Z2gIo1qKSVPfCXlGZyhbgG4v4ImAc/Cys/URTljLll1W5U9dEgXm8Y83Ulu5RWxa3/1IAc/M8l09aN88i0SxuRWgWsb7i6U5me6sK1nQzyYHREuPB0w81Fp0KZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiaj/8eQAB6FY/9LQZ79Uewop3CvspyLDOk5zReEdYQ=;
 b=IO+RuNqqLyKinaAbScAGZ4R4HOaPQxOQkttHf7GhMp5YYLwz0EtQpwjstVJ4s5VwxvwYHFav/muvhF4WbqIMN3gA8GMYMzR04NngcblYAEayq7cSemdZVLPBuOSGbZb+zoMIpgn6bHs1mAwN+sqwaIZUZaecRqmP7CyLCDDl4Ys=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5546.namprd13.prod.outlook.com (2603:10b6:a03:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 17:11:31 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 17:11:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
Thread-Topic: [PATCH] NFS: Handle missing attributes in OPEN reply
Thread-Index: AQHZH9NUhloWZMaUakmHx9w8Uho3Qa6NbEuAgAAEOoCAAAPtAIAAD/4AgALtsYCAAExXgIAABW8AgAV8BgCAAAPIAIAABbeAgAARtgA=
Date:   Mon, 9 Jan 2023 17:11:31 +0000
Message-ID: <FC25C4BD-F58B-499D-9E79-87E2065DCB2A@hammerspace.com>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
 <167279409373.13974.16504090316814568327@noble.neil.brown.name>
 <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
 <167279837032.13974.12155714770736077636@noble.neil.brown.name>
 <167295936597.13974.7568769884598065471@noble.neil.brown.name>
 <46f047159da42dadaca576e0a87a622539609730.camel@kernel.org>
 <167297692611.13974.5805041718280562542@noble.neil.brown.name>
 <CAN-5tyGRkKB-=9-HFXkDSu+--ghBNEfmfXO8yD7=2bo=aH4fhA@mail.gmail.com>
 <F3FEC918-730E-415A-AE9B-A713B0718015@hammerspace.com>
 <CAN-5tyGFE0C-Y4k25oEwyeeNyzri+J7CnCHRTDkChSZdhV3pvw@mail.gmail.com>
In-Reply-To: <CAN-5tyGFE0C-Y4k25oEwyeeNyzri+J7CnCHRTDkChSZdhV3pvw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5546:EE_
x-ms-office365-filtering-correlation-id: dab209fd-7771-4305-c111-08daf2648d94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJmRRayWCfEm148UaARd2vX6erbqfMWSoV//DCg7UXRaWm9slQ37gg5J71bKp41SWXM6NcOkTs+zHzXcsCdweozg/10LmNoKNuajpdt17OY1FByzM96RNTgWS16QX+ClYXSci2wANzJJp65tS4fqVgSXzUbRwVJ0Q6tkTE0mPD+VLQOwJ64JM5ZlrGdHrdFgKaEkjLHYBCayEu89LdbbYVHPJ+vURGvG8NPZXPtpLvUkm9zIf7tDenqedqABCEEoCkUQilv++P0GBfC1YfU5hrFc/IKo5/JIX8Ru4QymBDJ4aD+dlr6G77wurw4E9yEsfeQmjRWNhBpcsFmhoRLtcE5yEzqVWLP/ft2L+JuAN3Lvdye3caierTUd/AGjccBTNXCbvb8vniyXbmRukmKCr/LxT74FDhR1TzPRr24T205GoNQ0OaWB49k62dDsRa3qQTneaf9TeMtq9/t8zjZWKiQCZuHx+9/MkNM6rMrfDl4BIYsciizcCFDazn3OLT6Em+CRO/8/a+DUI8tM1WJVK0CTB4e2ygoheyvgeG3VJpvlEdyKd9Ot9tsTi14ft1iT52Z9hYTuPqd1A6549fXLBBT4f8H66WdH2rEKlqMDyZ4SO0OVrlOiEIbZBxgkME4tKNiArv4OJARHp22MZhL57C68ytJ03rQH1ddNOfxYPcFbimW/WUbaJ+8jpOgsQRGK2nRvcl1x2Yt1BT1SwSxsihWaI3V728PMu4ebf+5kqTg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199015)(6506007)(6512007)(186003)(2616005)(54906003)(76116006)(86362001)(8676002)(66476007)(66446008)(66946007)(66556008)(38070700005)(38100700002)(64756008)(122000001)(4326008)(5660300002)(478600001)(36756003)(6916009)(53546011)(2906002)(66899015)(26005)(71200400001)(316002)(33656002)(41300700001)(8936002)(83380400001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8KHYdXiO9iRdVzkv4NQqozNB7QexsekwtvhUPMY/pg7jB7pgtoVDEgURzKyF?=
 =?us-ascii?Q?pf145ybRNpD0lQVp0yZHbJv+zuy46Cp0wjAOBfIzyZN7TrfJnC7h25zQJWAw?=
 =?us-ascii?Q?HcbGNRC2RqyjsaFuul/RRPOOUnflKopK1BsafES9nAf7Il5dVn1yohd2wEyk?=
 =?us-ascii?Q?mRsnlhxD78l4nvmUUR0k8p376dDRfideZfT1+mTwR8oYznA2paWXIenMJqfO?=
 =?us-ascii?Q?g2jQjYurDuMzz0EaNuHJjx/ItbvEw4YUGzlyeVRYiklws5RhEc/2IUjA8TId?=
 =?us-ascii?Q?3KCHLINpO6JuTWhchdJopsCAu4h/ijaHuOdiRkFyEKppCcrEwslt/dm1aSep?=
 =?us-ascii?Q?2tVum5gOEpQvz6rX1uzwVssilLF1/mBHOONJjXZl/SpmmhVDWgJ9tNIvr60t?=
 =?us-ascii?Q?2eFdSppSjE1/ViEVMEds9P8lUkUjfAS/wDYBxmoJIsi4JNjGtuNYDbRs3A3d?=
 =?us-ascii?Q?lAA+gAFIKaZJVdPhiQWKq5nLuq7oGnuNlFNih8afXP7MWgqpGKWBCR6qH6h/?=
 =?us-ascii?Q?aCNkniWHooeQHo5NXWNAWi4QXwuvNPqhfVIGTXAAGr0WTtCvUPUU9Qnl1otH?=
 =?us-ascii?Q?2fJuEn95ai8F76xpieWzl2FW+IDij19YIKEyPdJUpsL7+waRSGh6vkNseg7n?=
 =?us-ascii?Q?yRVyldCG6bqF8C2VLO2KND0Fisi62aGtpbHfClgZVl4QQ2lMUG+H3nATUmzW?=
 =?us-ascii?Q?gsNyCFCSkRhrnyQrNJhIO5THjXUo6cVp4Zxn2EY1yNlqQREsGXSb3nAfDdBS?=
 =?us-ascii?Q?UpuVEdgkO2UhBBDS0K5D6tRHzU8U+PMsp8cB1mddXd5UbssiamJUJ8kL2jmZ?=
 =?us-ascii?Q?DsGP7THRyvTkiYghkf0P30rylcxelKk267bOZQ1P811lCuLfm8xnnIP5WHsg?=
 =?us-ascii?Q?DUQ+UYZGQuKY2IrTif3560+ZU9OFrxNiDK9DQiN4uUEBcaSszi/DRFFc+nHi?=
 =?us-ascii?Q?49ogdXZms8xFMe3rlvqnoijiZdqYc/BMROWoobl8BVdJhR9JhdeRZKHJD674?=
 =?us-ascii?Q?4Mf8+YB3lu9A+uyU1dHSjXw2Z2sXSh3TkrRQEB2G2KoQc80/w8gGMbNPXKFU?=
 =?us-ascii?Q?QYeiHgYAu14ZHPymyt+LnsA8IWWGaM2uYmAYeFte6eNjNFzE0Q7bD9R5L/pW?=
 =?us-ascii?Q?3A83uFnSvOycUnq8rXxse4b3iem9huQA/79M1pZgoAp/b2a9KpUdltbHSp9h?=
 =?us-ascii?Q?wNXiivLbKfV2tIQJcjX+/0BF9+ZXKu6JMWIVYb4f+flR1MHDYbdI3ev4NvYt?=
 =?us-ascii?Q?hh1BTVAwU1waAacieu9+zipcY2UTbWRCOn+MUH2nflPUUZXV+C9J6YmlLyuM?=
 =?us-ascii?Q?pEiefHZaT0b5/t8XCL1c34GjpYYA3VYCn7trL8I5MpLvr0OvIios4WTUAroH?=
 =?us-ascii?Q?fMhtwzicJCPeXio42FPo0r0736HF+wV60E8IJTkaV/ztqW1OE5p4Y5dqxliF?=
 =?us-ascii?Q?U9kzF7jJQVMxGzIjsEDVRchwDHQKZpH4j695p9mpl3YtaMQcEdk8f4syBwvy?=
 =?us-ascii?Q?haxnIDkpKDDjHZFMegXE71jy6c2AtrmyW+PglbppHPCJUxflrAvPtAoQLISu?=
 =?us-ascii?Q?0buUrxcTlLPlAcl2CFkNer3hi9IW0FiN7HvLYs9h6E/YGEKQz63vnDcsDIAi?=
 =?us-ascii?Q?1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10F873AF9A60594A9BF4549C6D6CA266@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab209fd-7771-4305-c111-08daf2648d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 17:11:31.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chc5DBZEoXphGYMSWRjdpkAJDUo0v8R5HWPHZ70JErckBI7ArhprCmLe4eBI3RT8kYcRnnBeOYJeoDgSC3myjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 9, 2023, at 11:07, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Mon, Jan 9, 2023 at 10:47 AM Trond Myklebust <trondmy@hammerspace.com>=
 wrote:
>>=20
>>=20
>>=20
>>> On Jan 9, 2023, at 10:33, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>=20
>>> On Thu, Jan 5, 2023 at 10:48 PM NeilBrown <neilb@suse.de> wrote:
>>>>=20
>>>> On Fri, 06 Jan 2023, Trond Myklebust wrote:
>>>>> On Fri, 2023-01-06 at 09:56 +1100, NeilBrown wrote:
>>>>>> On Wed, 04 Jan 2023, NeilBrown wrote:
>>>>>>> On Wed, 04 Jan 2023, Trond Myklebust wrote:
>>>>>>>> On Wed, 2023-01-04 at 12:01 +1100, NeilBrown wrote:
>>>>>>>>> On Wed, 04 Jan 2023, Trond Myklebust wrote:
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> If the server starts to reply NFS4ERR_STALE to GETATTR
>>>>>>>>>> requests,
>>>>>>>>>> why do
>>>>>>>>>> we care about stateid values? Just mark the inode as stale
>>>>>>>>>> and drop
>>>>>>>>>> it
>>>>>>>>>> on the floor.
>>>>>>>>>=20
>>>>>>>>> We have a valid state from the server - we really shouldn't
>>>>>>>>> just
>>>>>>>>> ignore
>>>>>>>>> it.
>>>>>>>>>=20
>>>>>>>>> Maybe it would be OK to mark the inode stale.  I don't know if
>>>>>>>>> various
>>>>>>>>> retry loops abort properly when the inode is stale.
>>>>>>>>=20
>>>>>>>> Yes, they are all supposed to do that. Otherwise we would end up
>>>>>>>> looping forever in close(), for instance, since the PUTFH,
>>>>>>>> GETATTR and
>>>>>>>> CLOSE can all return NFS4ERR_STALE as well.
>>>>>>>=20
>>>>>>> To mark the inode as STALE we still need to find the inode, and
>>>>>>> that is
>>>>>>> the key bit missing in the current code.  Once we find the inode,
>>>>>>> we
>>>>>>> could mark it stale, but maybe some other error resulted in the
>>>>>>> missing
>>>>>>> GETATTR...
>>>>>>>=20
>>>>>>> It might make sense to put the new code in _nfs4_proc_open() after
>>>>>>> the
>>>>>>> explicit nfs4_proc_getattr() fails.  We would need to find the
>>>>>>> inode
>>>>>>> given only the filehandle.  Is there any easy way to do that?
>>>>>>>=20
>>>>>>> Thanks,
>>>>>>> NeilBrown
>>>>>>>=20
>>>>>>=20
>>>>>> I couldn't see a consistent pattern to follow for when to mark an
>>>>>> inode
>>>>>> as stale.  Do this, on top of the previous patch, seem reasonable?
>>>>>>=20
>>>>>> Thanks,
>>>>>> NeilBrown
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>> index b441b1d14a50..04497cb42154 100644
>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>> @@ -489,6 +489,8 @@ static int nfs4_do_handle_exception(struct
>>>>>> nfs_server *server,
>>>>>>               case -ESTALE:
>>>>>>                       if (inode !=3D NULL && S_ISREG(inode->i_mode))
>>>>>>                               pnfs_destroy_layout(NFS_I(inode));
>>>>>> +                       if (inode)
>>>>>> +                               nfs_set_inode_stale(inode);
>>>>>=20
>>>>> This is normally dealt with in the generic code inside
>>>>> nfs_revalidate_inode(). There should be no need to duplicate it here.
>>>>>=20
>>>>>>                       break;
>>>>>>               case -NFS4ERR_DELEG_REVOKED:
>>>>>>               case -NFS4ERR_ADMIN_REVOKED:
>>>>>> @@ -2713,8 +2715,12 @@ static int _nfs4_proc_open(struct
>>>>>> nfs4_opendata *data,
>>>>>>                       return status;
>>>>>>       }
>>>>>>       if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
>>>>>> +               struct inode *inode =3D nfs4_get_inode_by_stateid(
>>>>>> +                       &data->o_res.stateid,
>>>>>> +                       data->owner);
>>>>>=20
>>>>> There shouldn't be a need to go looking for open descriptors here,
>>>>> because they will hit ESTALE at some point later anyway.
>>>>=20
>>>> The problem is that they don't hit ESTALE later.  Unless we update our
>>>> stored stateid with the result of the OPEN, we can use the old stateid=
,
>>>> and get the corresponding error.
>>>>=20
>>>> The only way to avoid the infinite loop is to either mark the inode as
>>>> stale, or update the state-id.  For either of those we need to find th=
e
>>>> inode.  We don't have fileid so we cannot use iget.  We do have file
>>>> handle and state-id.
>>>>=20
>>>> Maybe you are saying this is a server bug that the client cannot be
>>>> expect to cope with at all, and that an infinite loop is a valid clien=
t
>>>> response to this particular server behaviour.  In that case, I guess n=
o
>>>> patch is needed.
>>>=20
>>> I'm not arguing that the server should do something else. But I would
>>> like to talk about it from the spec perspective. When PUTFH+WRITE is
>>> sent to the server (with an incorrect stateid) and it's processing the
>>> WRITE compound (as the spec doesn't require the server to validate a
>>> filehandle on PUTFH. The spec says PUTFH is to "set" the correct
>>> filehandle), the server is dealing with 2 errors that it can possibly
>>> return to the client ERR_STALE and ERR_OLD_STATEID. There is nothing
>>> in the spec that speaks to the orders of errors to be returned. Of
>>> course I'd like to say that the server should prioritize ERR_STALE
>>> over ERR_OLD_STATEID (simply because it's a MUST in the spec and
>>> ERR_OLD_STATEIDs are written as "rules").
>>>=20
>>=20
>> I disagree for the reason already pointed to in the spec. There is nothi=
ng in the spec that appears to allow the PUTFH to return anything other tha=
n NFS4ERR_STALE after the file has been deleted (and yes, RFC5661, Section =
15.2 does list NFS4ERR_STALE as an error for PUTFH). PUTFH is definitely re=
quired to validate the file handle, since it is the ONLY operation that can=
 return NFS4ERR_BADHANDLE.
>=20
> We are talking about 4.0 and not 4.1. In 4.0 all operations that use
> PUTFH can return ERR_BADHANDLE.

Same difference: RFC7530 Section 4.2.2 uses the exact same language as in R=
FC5661 to describe how file handles work for deleted files, and RFC7530 Sec=
tion 13.2 list NFS4ERR_STALE as being a valid error for PUTFH.

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

