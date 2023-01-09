Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DAA662A80
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjAIPtJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 10:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjAIPrw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 10:47:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2132.outbound.protection.outlook.com [40.107.93.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A6C6
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 07:47:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f62WF+zKkH3xAHNxA0PSiTtN7vtKQ9Y910q1gkijGXE6PAhpv4QQM5ZoRuLY38TWtAmGYinYkmi9pqboEomL9P1nCl1F5Jm7U/vENzpai98efsSspgWzu5ergHZZCKOk0RA3WvucE1TrnrINHWrjVsJirMhobb5VmBHreMAxMJN89lWwaV5vQAsTA/1kCNyri+uDhxqNRe5fkkmFurB8wcFigJhqgl2mtdoqk9h55+bHkHcLXpY/Id5bn7/3phE7i3MYbeXszu3OdDa644ezN3AT8lTm7VnPY0u3q7xGofwXpu8mLBD8GWS8adN/DCff92wIC8VHSsv2q2lEr3OfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAsvKh4DqWkofkBvSJPD1z3riquibxY8scPn7vO/zY0=;
 b=lYBiUOifomcDMhrvTrFb4n3W+1WYybWhlyhcKEkHNx2EmlJueRTKD/s17pgDm4k6Idhqa3manFch3SqFnED65lpAlk1KIz259LwZ497kL+a+Tq1qD9fcocS2yYRqEkbI0l9eGkNPuAaby3JtmvtWs6s+TKY1sFryrMxpXgU3bljh9E/FctqfOqmVoHcdDaU56YlIbQtVx7Tc6rPwRe8cOEI4lAMfq79nary/Yow9Rvy57uOmh7SxgTWs224XmDFvnBVP2k+UaTcrsiBw5TLbk2YP0BHgQxNO+vij+W6dZvyoaGxQSpIzg8NXxSnHYsXElIjW/Pta9AEuhnr68eeDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAsvKh4DqWkofkBvSJPD1z3riquibxY8scPn7vO/zY0=;
 b=YFT1Hp2zovSY/0dDGoC5EBQL43aK6xviZX6M/bbOd8DDnlfxBQfoBBk9cR4AGCjxOfJYwSfPy+Z7gV4HZy/5Hc1ha2WMxv7rvVt+zW8bZK/UDU2m2+NsqHRQyeEnZNEkA+gkBvgAR3Jq18VHZQIirFX5pfvW8L+a4Szk4TU24dY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL0PR13MB4417.namprd13.prod.outlook.com (2603:10b6:208:1c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 15:47:40 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 15:47:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
Thread-Topic: [PATCH] NFS: Handle missing attributes in OPEN reply
Thread-Index: AQHZH9NUhloWZMaUakmHx9w8Uho3Qa6NbEuAgAAEOoCAAAPtAIAAD/4AgALtsYCAAExXgIAABW8AgAV8BgCAAAPIAA==
Date:   Mon, 9 Jan 2023 15:47:40 +0000
Message-ID: <F3FEC918-730E-415A-AE9B-A713B0718015@hammerspace.com>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
 <167279409373.13974.16504090316814568327@noble.neil.brown.name>
 <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
 <167279837032.13974.12155714770736077636@noble.neil.brown.name>
 <167295936597.13974.7568769884598065471@noble.neil.brown.name>
 <46f047159da42dadaca576e0a87a622539609730.camel@kernel.org>
 <167297692611.13974.5805041718280562542@noble.neil.brown.name>
 <CAN-5tyGRkKB-=9-HFXkDSu+--ghBNEfmfXO8yD7=2bo=aH4fhA@mail.gmail.com>
In-Reply-To: <CAN-5tyGRkKB-=9-HFXkDSu+--ghBNEfmfXO8yD7=2bo=aH4fhA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BL0PR13MB4417:EE_
x-ms-office365-filtering-correlation-id: 861b6e64-4df9-4015-08c8-08daf258d731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Z52k4xMibmqFlblvZ820AG6X8of6x/6hn25wpjekCJlV+IoMPJVWJoNrom3zTRhsos4KvunKodHel2otK8ZGoCyIhoExdFOphMFxHui100tiAUNGIzFJjAU6bh+Q+WVIQA4VqdA8VpqTroZv3KhZJGX6doGGn9dIjImip5x/amBotnjseuYmaDb79oL74qkHGPwOdZD+agj/VH59QhQJh9LlREiZEZ4Juj1qE396YX8lYVUEiaqF7uZMpFBx3vdeMhSi+Y9YRUs37COHoclffxdW7iCxmrfOTwO8IOEnJRXNho6OdOF93uq7QjoDnbdJ+NOpiIlwTi9ewcrCX0jKOoMGPd7RNitIGsuQGT7OfS5iN29IUrbL+ASG137PTfAlaj+fvJjvr/PXH1JIE3W9q1K4f2rPw6mQRuW1RNdkuSzhhSPL2vTEg+a0YtieVkjmQLQmvqtDRE7ft8QwrlbHOz+Fn1cW1Nj1NE0SOI2qv0Y2HPwiVGmlVVSsiC4xgJYfl9dYz6hajDRjuCKCDrsaM7ICmTbj2pSrIHytjnsVkdUdVgOLY2n55+j6ukEYe1hRsRtHsAjwNs/4VizXN8sM2XpnYHKd0spxGTgHktzxDqCbaJrQ9rT++96ipS46zTWv+H4ToolJqYt1xMTE/TLgS/KMNR+/vbu1Ml6A7BDjuwAOzj4AXg0VLOLjwsXm2JKFXEt8SWAlLohbLygiWs28yceH7N10accfzHBgV+7pJL6Pgr4vf6NAG1wAB0FHrBaQ0RgN/Z7WavPb8eu0c0Dsf0AxNCJkWiWnYte1sV53pg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(39830400003)(396003)(451199015)(8676002)(33656002)(316002)(5660300002)(71200400001)(26005)(6512007)(6486002)(478600001)(186003)(2616005)(41300700001)(66946007)(4326008)(6916009)(64756008)(66556008)(76116006)(66476007)(54906003)(66446008)(8936002)(83380400001)(36756003)(38070700005)(86362001)(53546011)(6506007)(122000001)(38100700002)(66899015)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VbQyS2/XrCAuzXVmM0mAWRPj5ZDH8Kw8C6nryjVtmymYRZvnEj8zQrU6TdaJ?=
 =?us-ascii?Q?4riC/sh8eYeyUfAmj3yiojDkk99fLdBy35nuOPFIus+XDN0wGEvIn8x9aW7L?=
 =?us-ascii?Q?nGRfcD3eh3RuUrRbW6Gvp4TRXZAKBsbaieMTO+xmZ6jcdvwTSLLltNXhkIW/?=
 =?us-ascii?Q?HTEDNL2HhyidFqmlyJqaTPJk3OqBIcSDoAY+Vb3f0WYY9OS7JR34hQowBmJw?=
 =?us-ascii?Q?wcVMhrCe3UqEFo4SrnIACylkMZ5MLaVCYQNjOxQi+lbBHTA2wbPcNktPQTrV?=
 =?us-ascii?Q?nSJlQ8CNV5Tt77srIUiXBOYEwRlcOtv0TSjk9FWdAUdT7nVTfDfxZpPn/dhy?=
 =?us-ascii?Q?qNupF8z/NSPVvkN8h7B8RUTHdV/btUfIAfZJhzmLY2xx7uLJW6c6dG4rz1pW?=
 =?us-ascii?Q?KMifWTGkGsyossaubl0kgS1HeXEWnfgoF/pOneDOTiTfaVDKquxl3VwjjbPJ?=
 =?us-ascii?Q?6y6XAdzmmxkXhUoCCJVLXjRbnvRhq5AzKlaroEwVjCo+Y718SVMUdaAp5ey5?=
 =?us-ascii?Q?/JdvN7dAfkd6GAnn1y/34orNL6BatKqBnxLwplaZS4/VQ5kwc5zpjiG6lfBS?=
 =?us-ascii?Q?oOVlLCmouk0OO8SyhBPgKGif1+qHULeSj3Dg3zDgdsHeXRosx5/UsTMUaemK?=
 =?us-ascii?Q?8qYnL7ARo27A0bb09OauSgyuyFQGxyI6hLEvqemLC9DqcCFfDCwtu/f6Qfac?=
 =?us-ascii?Q?ZO5qyLi7RGI4ianC/pbYoYsix2Yk9WxHGLhUreFQ+ZneeeYOUzgK+IC/Pjxx?=
 =?us-ascii?Q?DgRN9txjTtrNwROSaicWu4J2uKiUDBMLavYlcc7Bkc3auhfYf2sZoEGVl3yE?=
 =?us-ascii?Q?QduAi30qVFU6avJR6wTwBahuqMUxiSHdGuYmdYim5vGiJio8/nou8G0SZnod?=
 =?us-ascii?Q?ldE6gvRPf7Tvm/AVLr8/kdX6y3sJZDY7Qv5/o9DHLUNiYfEJ/+tdBCkSixO1?=
 =?us-ascii?Q?no0tOxdihnsACER1TEoRR8yZ+VuP+zxUAODUMbYK7kMKRZ+RxovJwQOXp+I+?=
 =?us-ascii?Q?2Mt7WA4SppT3DZB9T7FYX9mPRtVUFedWjVk88gwFZjrD2KOGuSuiQ+a9rA0g?=
 =?us-ascii?Q?iflQbBYSrQdkIFj6FMz4uPdfNxhwpW+cM2jBZF/71Tbc/F+4n5/kPGolNwJ8?=
 =?us-ascii?Q?T7s0ZAiGCyZeSzNd+/ndXcN7r7WcXX1QDyrAIuFFi3QJFdVOot9Hq/0ZtO6E?=
 =?us-ascii?Q?SSqjpCl9S6/eUU70+cctoON/SOEJBLHHtAYWL0dRQAtjeufzLgb9XjbwnmZJ?=
 =?us-ascii?Q?6pGIbtrhUIzYM+Zqs8fl6IAsEe8Bpy2Z/TiDwvy+1G7Ya04nehUcJ8ckqY/T?=
 =?us-ascii?Q?NNNpwR+bg3gw6RbHf0qoIyg4yHG7T52hau1TxKXP82QckSfrEHsF16MWw4ZK?=
 =?us-ascii?Q?hTt2ArSrIeg1XAU+wi4SWcHi3OJY2uEv0Yh/XFCHST4G9M1nUC0/gCc79hBZ?=
 =?us-ascii?Q?oSPX5roDdw5uCX4HlGHwZBMqNkRVex/FzXfwwXQSi4slQrNznEO8U4oLFaLT?=
 =?us-ascii?Q?IsTlf8DAzCdOgt4kREZYokFXpiL7m6xVqrqD9cCAaU/LZFHFVHqgTEG+22AN?=
 =?us-ascii?Q?U6j3VMZ7yxWKxOnyb64Y+jYtK5YncloDgLDyEhE9bbcn5XEXF/quQV+d3O5l?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07636A7A17AE9C43BD716457814C8627@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861b6e64-4df9-4015-08c8-08daf258d731
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 15:47:40.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TV9muHluHSbqGBi34lYNMg61iHlfZMfO/lfRBiZZXqaM9+tsPLpaRKxupuNQYVDHZ12QkYsmZXiQrADRIWdf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 9, 2023, at 10:33, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Thu, Jan 5, 2023 at 10:48 PM NeilBrown <neilb@suse.de> wrote:
>>=20
>> On Fri, 06 Jan 2023, Trond Myklebust wrote:
>>> On Fri, 2023-01-06 at 09:56 +1100, NeilBrown wrote:
>>>> On Wed, 04 Jan 2023, NeilBrown wrote:
>>>>> On Wed, 04 Jan 2023, Trond Myklebust wrote:
>>>>>> On Wed, 2023-01-04 at 12:01 +1100, NeilBrown wrote:
>>>>>>> On Wed, 04 Jan 2023, Trond Myklebust wrote:
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> If the server starts to reply NFS4ERR_STALE to GETATTR
>>>>>>>> requests,
>>>>>>>> why do
>>>>>>>> we care about stateid values? Just mark the inode as stale
>>>>>>>> and drop
>>>>>>>> it
>>>>>>>> on the floor.
>>>>>>>=20
>>>>>>> We have a valid state from the server - we really shouldn't
>>>>>>> just
>>>>>>> ignore
>>>>>>> it.
>>>>>>>=20
>>>>>>> Maybe it would be OK to mark the inode stale.  I don't know if
>>>>>>> various
>>>>>>> retry loops abort properly when the inode is stale.
>>>>>>=20
>>>>>> Yes, they are all supposed to do that. Otherwise we would end up
>>>>>> looping forever in close(), for instance, since the PUTFH,
>>>>>> GETATTR and
>>>>>> CLOSE can all return NFS4ERR_STALE as well.
>>>>>=20
>>>>> To mark the inode as STALE we still need to find the inode, and
>>>>> that is
>>>>> the key bit missing in the current code.  Once we find the inode,
>>>>> we
>>>>> could mark it stale, but maybe some other error resulted in the
>>>>> missing
>>>>> GETATTR...
>>>>>=20
>>>>> It might make sense to put the new code in _nfs4_proc_open() after
>>>>> the
>>>>> explicit nfs4_proc_getattr() fails.  We would need to find the
>>>>> inode
>>>>> given only the filehandle.  Is there any easy way to do that?
>>>>>=20
>>>>> Thanks,
>>>>> NeilBrown
>>>>>=20
>>>>=20
>>>> I couldn't see a consistent pattern to follow for when to mark an
>>>> inode
>>>> as stale.  Do this, on top of the previous patch, seem reasonable?
>>>>=20
>>>> Thanks,
>>>> NeilBrown
>>>>=20
>>>>=20
>>>>=20
>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>> index b441b1d14a50..04497cb42154 100644
>>>> --- a/fs/nfs/nfs4proc.c
>>>> +++ b/fs/nfs/nfs4proc.c
>>>> @@ -489,6 +489,8 @@ static int nfs4_do_handle_exception(struct
>>>> nfs_server *server,
>>>>                case -ESTALE:
>>>>                        if (inode !=3D NULL && S_ISREG(inode->i_mode))
>>>>                                pnfs_destroy_layout(NFS_I(inode));
>>>> +                       if (inode)
>>>> +                               nfs_set_inode_stale(inode);
>>>=20
>>> This is normally dealt with in the generic code inside
>>> nfs_revalidate_inode(). There should be no need to duplicate it here.
>>>=20
>>>>                        break;
>>>>                case -NFS4ERR_DELEG_REVOKED:
>>>>                case -NFS4ERR_ADMIN_REVOKED:
>>>> @@ -2713,8 +2715,12 @@ static int _nfs4_proc_open(struct
>>>> nfs4_opendata *data,
>>>>                        return status;
>>>>        }
>>>>        if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
>>>> +               struct inode *inode =3D nfs4_get_inode_by_stateid(
>>>> +                       &data->o_res.stateid,
>>>> +                       data->owner);
>>>=20
>>> There shouldn't be a need to go looking for open descriptors here,
>>> because they will hit ESTALE at some point later anyway.
>>=20
>> The problem is that they don't hit ESTALE later.  Unless we update our
>> stored stateid with the result of the OPEN, we can use the old stateid,
>> and get the corresponding error.
>>=20
>> The only way to avoid the infinite loop is to either mark the inode as
>> stale, or update the state-id.  For either of those we need to find the
>> inode.  We don't have fileid so we cannot use iget.  We do have file
>> handle and state-id.
>>=20
>> Maybe you are saying this is a server bug that the client cannot be
>> expect to cope with at all, and that an infinite loop is a valid client
>> response to this particular server behaviour.  In that case, I guess no
>> patch is needed.
>=20
> I'm not arguing that the server should do something else. But I would
> like to talk about it from the spec perspective. When PUTFH+WRITE is
> sent to the server (with an incorrect stateid) and it's processing the
> WRITE compound (as the spec doesn't require the server to validate a
> filehandle on PUTFH. The spec says PUTFH is to "set" the correct
> filehandle), the server is dealing with 2 errors that it can possibly
> return to the client ERR_STALE and ERR_OLD_STATEID. There is nothing
> in the spec that speaks to the orders of errors to be returned. Of
> course I'd like to say that the server should prioritize ERR_STALE
> over ERR_OLD_STATEID (simply because it's a MUST in the spec and
> ERR_OLD_STATEIDs are written as "rules").
>=20

I disagree for the reason already pointed to in the spec. There is nothing =
in the spec that appears to allow the PUTFH to return anything other than N=
FS4ERR_STALE after the file has been deleted (and yes, RFC5661, Section 15.=
2 does list NFS4ERR_STALE as an error for PUTFH). PUTFH is definitely requi=
red to validate the file handle, since it is the ONLY operation that can re=
turn NFS4ERR_BADHANDLE.

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

