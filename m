Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6F665BAC
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 13:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjAKMoJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 07:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjAKMoI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 07:44:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662A6E5
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 04:44:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0126F614D4
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 12:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC827C433EF;
        Wed, 11 Jan 2023 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673441046;
        bh=zyzqqrJgTgFcOUI8A/0Op9omv/GZhVosaXLWsaSdflk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kPshmHsCamOY+vo1vRn18+hfJbJajNi8CDL/ryRkbB0D5goehIx3smPwN6nEaNmjL
         JkPElJo5fgE5FWe7FeB1+qSfH+SaYUyPi/KH5btX60++fFQSjF+9aq/U/dPZB8oczp
         Kyr2Wfg5h0jiLVIFBm/Ap163JLE6x//qSjc7LAmvgdvwXqzzJl0wNexr4WBmXZ3nHY
         pbCUOr94TrSU8kWTwI4i/xAbhSbfNTPAQH/+MuIw/wXnRcwq+KvAIbgDhext48GLDP
         TvQHBLhIyMvdmv/YoHLvp6vdLOvoSK9tTRKGcznxl8vkLovYzTMnhBPf1cMcDT2lxr
         wXrlgz5GQB2cQ==
Message-ID: <78579e0d1ca805bad4c98c609638305fa63cda67.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Mike Galbraith <efault@gmx.de>, dai.ngo@oracle.com,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 07:44:04 -0500
In-Reply-To: <860d74c0a13c8c8330bed91b8085384399e14764.camel@gmx.de>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
         <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
         <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
         <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
         <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
         <3b7b3462-0f15-58a7-b49c-eb563d20a8ec@oracle.com>
         <860d74c0a13c8c8330bed91b8085384399e14764.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 13:26 +0100, Mike Galbraith wrote:
> On Wed, 2023-01-11 at 03:31 -0800, dai.ngo@oracle.com wrote:
> >=20
> > Can you try:
> >=20
> > crash7latest> nfsd_net_id
> > nfsd_net_id =3D $2 =3D 9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <=
<=3D=3D=3D
> > crash7latest> struct net.gen=A0 init_net
> > =A0=A0 gen =3D 0xffff97fc17d07d80
> > crash7latest> x /10g 0xffff97fc17d07d80
> > 0xffff97fc17d07d80:=A0=A0=A0=A0=A00x000000000000000d=A0=A0=A0=A0=A0=A00=
x0000000000000000
> > 0xffff97fc17d07d90:=A0=A0=A0=A0=A00x0000000000000000=A0=A0=A0=A0=A0=A00=
xffff97fc0ac40060
> > 0xffff97fc17d07da0:=A0=A0=A0=A0=A00xffff994e7bf87600=A0=A0=A0=A0=A0=A00=
xffff98f731172a20
> > 0xffff97fc17d07db0:=A0=A0=A0=A0=A00xffff9844b05d9c00=A0=A0=A0=A0=A0=A00=
xffff9832a6a0add0
> > 0xffff97fc17d07dc0:=A0=A0=A0=A0=A00xffff984a4470d740=A0=A0=A0=A0=A0=A00=
xffff984a93eb0600=A0=A0=A0
> > <<=3D=3D=3D entry for nfsd_net_id
> > crash7latest> nfsd_net 0xffff984a93eb0600
>=20
> (monkey see monkey do.. eep eep)
>=20
> crash> nfsd_net_id
> p: gdb request failed: p nfsd_net_id
> crash> struct net.gen  init_net
>   gen =3D 0xffff88810b7b8a00,
> crash> x /10g 0xffff88810b7b8a00
> 0xffff88810b7b8a00:	0x0000000000000010	0x0000000000000000
> 0xffff88810b7b8a10:	0x0000000000000000	0xffff888101563380
> 0xffff88810b7b8a20:	0xffff888101ebd900	0xffff888101ebda00
> 0xffff88810b7b8a30:	0xffff888101f88b80	0xffff8881022056c0
> 0xffff88810b7b8a40:	0xffff888133b79e00	0xffff888110a2ca00
> crash> nfsd_net 0xffff888110a2ca00
> struct nfsd_net {
>   cld_net =3D 0xffff888131c3c000,
>   svc_expkey_cache =3D 0xffff888110a2cc00,
>   svc_export_cache =3D 0xffff888110a2ce00,
>   idtoname_cache =3D 0xffff8881061a8a00,
>   nametoid_cache =3D 0xffff8881061a8c00,
>   nfsd4_manager =3D {
>     list =3D {
>       next =3D 0xffff888141efa000,
>       prev =3D 0xffff888133e6ea00
>     },
>     block_opens =3D false
>   },
>   grace_ended =3D false,
>   boot_time =3D -131387065447864,
>   nfsd_client_dir =3D 0xffff888110a2ca48,
>   reclaim_str_hashtbl =3D 0xffff88810bed7408,
>   reclaim_str_hashtbl_size =3D 1083333640,
>   conf_id_hashtbl =3D 0x0,
>   conf_name_tree =3D {
>     rb_node =3D 0xffff888140925c00
>   },
>   unconf_id_hashtbl =3D 0xffff88810181c800,
>   unconf_name_tree =3D {
>     rb_node =3D 0x200000000
>   },
>   sessionid_hashtbl =3D 0x1,
>   client_lru =3D {
>     next =3D 0x0,
>     prev =3D 0x0
>   },
>   close_lru =3D {
>     next =3D 0xffff888110a2caa0,
>     prev =3D 0xffff888110a2caa0
>   },
>   del_recall_lru =3D {
>     next =3D 0x0,
>     prev =3D 0xffffffffffffffff
>   },
>   blocked_locks_lru =3D {
>     next =3D 0x0,
>     prev =3D 0xffff88810a0e0f00
>   },
>   laundromat_work =3D {
>     work =3D {
>       data =3D {
>         counter =3D 0
>       },
>       entry =3D {
>         next =3D 0x0,
>         prev =3D 0x0
>       },
>       func =3D 0x0
>     },
>     timer =3D {
>       entry =3D {
>         next =3D 0x0,
>         pprev =3D 0x0
>       },
>       expires =3D 520729437059154371,
>       function =3D 0x0,
>       flags =3D 3526430787
>     },
>     wq =3D 0x24448948f6314540,
>     cpu =3D 1133332496
>   },
>   client_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 344528932
>             },
>             {
>               locked =3D 36 '$',
>               pending =3D 24 '\030'
>             },
>             {
>               locked_pending =3D 6180,
>               tail =3D 5257
>             }
>           }
>         }
>       }
>     }
>   },
>   blocked_locks_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 1820937252
>             },
>             {
>               locked =3D 36 '$',
>               pending =3D 76 'L'
>             },
>             {
>               locked_pending =3D 19492,
>               tail =3D 27785
>             }
>           }
>         }
>       }
>     }
>   },
>   rec_file =3D 0x4808245c89483824,
>   in_grace =3D 137,
>   client_tracking_ops =3D 0xe8df8948005d8b,
>   nfsd4_lease =3D -8266309238763028480,
>   nfsd4_grace =3D 5476377146897729659,
>   somebody_reclaimed =3D 139,
>   track_reclaim_completes =3D 99,
>   nr_reclaim_complete =3D {
>     counter =3D -402096755
>   },
>   nfsd_net_up =3D false,
>   lockd_up =3D false,
>   writeverf_lock =3D {
>     seqcount =3D {
>       seqcount =3D {
>         sequence =3D 140872013
>       }
>     },
>     lock =3D {
>       {
>         rlock =3D {
>           raw_lock =3D {
>             {
>               val =3D {
>                 counter =3D -387479220
>               },
>               {
>                 locked =3D 76 'L',
>                 pending =3D 137 '\211'
>               },
>               {
>                 locked_pending =3D 35148,
>                 tail =3D 59623
>               }
>             }
>           }
>         }
>       }
>     }
>   },
>   writeverf =3D "\000\000\000\000M\211,$",
>   max_connections =3D 612141896,
>   clientid_base =3D 59416,
>   clientid_counter =3D 2336751616,
>   clverifier_counter =3D 1275601988,
>   nfsd_serv =3D 0x1024448b48185889,
>   keep_active =3D 140740940,
>   s2s_cp_cl_id =3D 1223133516,
>   s2s_cp_stateids =3D {
>     idr_rt =3D {
>       xa_lock =3D {
>         {
>           rlock =3D {
>             raw_lock =3D {
>               {
>                 val =3D {
>                   counter =3D 15205257
>                 },
>                 {
>                   locked =3D 137 '\211',
>                   pending =3D 3 '\003'
>                 },
>                 {
>                   locked_pending =3D 905,
>                   tail =3D 232
>                 }
>               }
>             }
>           }
>         }
>       },
>       xa_flags =3D 1224736768,
>       xa_head =3D 0xf74f6854d241c89
>     },
>     idr_base =3D 276532552,
>     idr_next =3D 232
>   },
>   s2s_cp_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 1933134848
>             },
>             {
>               locked =3D 0 '\000',
>               pending =3D 76 'L'
>             },
>             {
>               locked_pending =3D 19456,
>               tail =3D 29497
>             }
>           }
>         }
>       }
>     }
>   },
>   nfsd_versions =3D 0x443924048b012404,
>   nfsd4_minorversions =3D 0x2b4820f2424,
>   drc_hashtbl =3D 0x8678d4d107b8d48,
>   max_drc_entries =3D 232,
>   maskbits =3D 1938508800,
>   drc_hashsize =3D 4287187984,
>   num_drc_entries =3D {
>     counter =3D 232
>   },
>   counter =3D {{
>       lock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 931745024
>             },
>             {
>               locked =3D 0 '\000',
>               pending =3D 77 'M'
>             },
>             {
>               locked_pending =3D 19712,
>               tail =3D 14217
>             }
>           }
>         }
>       },
>       count =3D -8858645092202691189,
>       list =3D {
>         next =3D 0x24648b4cffffff43,
>         prev =3D 0x246c8b4c24148b40
>       },
>       counters =3D 0xffffffffa0d0b540 <__this_module>
>     }, {
>       lock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 256
>             },
>             {
>               locked =3D 0 '\000',
>               pending =3D 1 '\001'
>             },
>             {
>               locked_pending =3D 256,
>               tail =3D 0
>             }
>           }
>         }
>       },
>       count =3D -131387314532352,
>       list =3D {
>         next =3D 0x0,
>         prev =3D 0xffffffffa0c949c0 <svc_udp_ops+1248>
>       },
>       counters =3D 0xffffffffa0c67f00 <ip_map_put>
>     }},
>   longest_chain =3D 2697366144,
>   longest_chain_cachesize =3D 4294967295,
>   nfsd_reply_cache_shrinker =3D {
>     count_objects =3D 0xffffffffa0c67cd0 <ip_map_request>,
>     scan_objects =3D 0xffffffffa0c68e40 <ip_map_parse>,

Looks like this part of the struct may have been overwritten with
ip_map_cache_template ? Nothing else in here looks recognizable, so I
have to wonder if you actually have the correct nfsd_net pointer here.

>     batch =3D -1597606560,
>     seeks =3D 0,
>     flags =3D 0,
>     list =3D {
>       next =3D 0xffffffffa0c67350 <ip_map_alloc>,
>       prev =3D 0x0
>     },
>     nr_deferred =3D 0xffffffffa0c68a00 <ip_map_match>
>   },
>   nfsd_ssc_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D -1597603936
>             },
>             {
>               locked =3D 160 '\240',
>               pending =3D 127 '\177'
>             },
>             {
>               locked_pending =3D 32672,
>               tail =3D 41158
>             }
>           }
>         }
>       }
>     }
>   },
>   nfsd_ssc_mount_list =3D {
>     next =3D 0xffffffffa0c68b10 <update>,
>     prev =3D 0x49
>   },
>   nfsd_ssc_waitq =3D {
>     lock =3D {
>       {
>         rlock =3D {
>           raw_lock =3D {
>             {
>               val =3D {
>                 counter =3D -1596979232
>               },
>               {
>                 locked =3D 224 '\340',
>                 pending =3D 7 '\a'
>               },
>               {
>                 locked_pending =3D 2016,
>                 tail =3D 41168
>               }
>             }
>           }
>         }
>       }
>     },
>     head =3D {
>       next =3D 0xffff888110a2ce88,
>       prev =3D 0xc2
>     }
>   },
>   nfsd_name =3D "\001\000\000\000\000\000\000\000\200\t\021D\201\210\377\=
377\200\t\021D\201\210\377\377\001\000\000\000\000\000\000\000\032\000\000\=
000\000\000\000\000\377\377\377\377\377\377\377\377\000\301\303\061\201\210=
\377\377@$\234\203\377\377\377\377",
>   fcache_disposal =3D 0x0,
>   siphash_key =3D {
>     key =3D {0, 0}
>   },
>   nfs4_client_count =3D {
>     counter =3D 451
>   },
>   nfs4_max_clients =3D 122552490,
>   nfsd_courtesy_clients =3D {
>     counter =3D 0
>   },
>   nfsd_client_shrinker =3D {
>     count_objects =3D 0xe8000002a0a3894c,
>     scan_objects =3D 0x98b3894400000000,
>     batch =3D 5483261796049485826,
>     seeks =3D 15267721,
>     flags =3D 1275068416,
>     list =3D {
>       next =3D 0x18247c8d4918658b,
>       prev =3D 0x7c8b4900000000e8
>     },
>     nr_deferred =3D 0x4800000000e81824
>   },
>   nfsd_shrinker_work =3D {
>     work =3D {
>       data =3D {
>         counter =3D -8554306017173128307
>       },
>       entry =3D {
>         next =3D 0x894c00000000e8c4,
>         prev =3D 0xf7894c00000268a3
>       },
>       func =3D 0x6d8b4800000000e8
>     },
>     timer =3D {
>       entry =3D {
>         next =3D 0x270bb8d4818,
>         pprev =3D 0xbb8d4800000000e8
>       },
>       expires =3D 8118733695596102332,
>       function =3D 0xe8000002,
>       flags =3D 45908935
>     },
>     wq =3D 0x147424e783410000,
>     cpu =3D 553616193
>   }
> }
> crash>
>=20

--=20
Jeff Layton <jlayton@kernel.org>
